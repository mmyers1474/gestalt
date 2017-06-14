#!/bin/bash
#[[ "${HOME}/bin/shelldev.sh" ]] && source "${HOME}/bin/shelldev.sh"

declare -a vhosts
declare noclr=$'\e[39m'
declare runner="........................................";
declare list_hosts="no"
declare hosts_list="no"
declare config_isremote="no"
declare config_host=""
declare config_location="${PWD}"
declare use_intermediary="yes"
declare intermediary="localhost"
declare ignore_host_port="no"
declare open_in_browser="no"

function show_usage() {
cat <<EOF
Usage: $0 
Options:
        h               This help message
        p <pattern>     Specify the pattern with wildcards for the links to search for.
        s               Non-interactive, silent mode.  No prompts, defaults to yes.
        d               Dry run, no actual changes are made.
EOF

exit 0
}

function sshproxy () {
    sub_cmd="${1}"
    proxy_addr="${2}"

    case "${sub_cmd}" in
        'start')
            echo "Starting SSH for a SOCKS proxy tunnel."
            ssh -D -1080 -f -C -T -q -N -n "${proxy_addr}" && sshproxy_pid="$!"
            ;;
        'status')
            if [[ -n "${sshproxy_pid}" ]] && [[ -n $(ps -ef | grep ${sshproxy_pid}) ]]; then
                echo "The SSH SOCKS proxy is running."
            else
                echo "The SSH SOCKS proxy is NOT running."
            fi
            ;;
        'stop')
            if [[ -z ${sshproxy_pid} ]] || [[ -z $(ps -ef | grep ${ssh-pid}) ]]; then
                kill -1 -p ${sshproxy_pid}; read -t 5
                [[ -z ${sshproxy_pid} ]] && kill -2 -p ${sshproxy_pid}; read -t 5
                [[ -z ${sshproxy_pid} ]] && kill -3 -p ${sshproxy_pid}; read -t 5
                [[ -z ${sshproxy_pid} ]] && kill -9 -p ${sshproxy_pid}; read -t 5
                [[ -z ${sshproxy_pid} ]] && echo "Unable to kill SSH SOCKS proxy process."
            fi
            ;;
    esac
}

while getopts "l:c:i:dpbh" opt; do
    case ${opt} in
        d)  # Dump the list of hosts and ports extracted from the virtual host configuration.
            list_hosts="yes"
            ;;
        l)  # Process the configuration file specified by -s as a flat text hostname list.
            hosts_list="yes"
            list="${OPTARG}"
            if ! [[ -f "${list}" ]]; then
                echo "The -l argument requires an additional parameter specifying which file you wish to load the list of hosts from."
                echo "Please specify the file you wish to use."
                exit 1
            fi
            ;;
        c)  # Set the path to the configuration file or directory.
            config_location="${OPTARG}"
            if [[ ${config_location} =~ (:) ]]; then
                config_isremote="yes"
                config_host="${config_location%%:*}"
                config_location="${config_location##*:}"
            elif ! [[ -d "${config_location}" ]] && ! [[ -f "${config_location}" ]]; then
                echo "The -c argument requires an additional parameter specifying which directory or file you wish to load the list of URL's from."
                echo "The default is the current working directory."
                echo "Please specify the file/directory you wish to use."
                exit 1
            fi
            ;;
        p)  # Set the flag to ignore the http port specified in the hosts list or vhost configuration.
            ignore_host_port="yes"
            ;;
        i)  # Connect to the host through an intermediary using the server name as the host request header..
            use_intermediary="yes"
            intermediary="${OPTARG}"
            ;;
        b)  # Open each virtual host checked in a local browser tab as well.
            open_in_browser="yes"
            ;;
        h)  # Display help message
            exit 0
            ;;
    esac
done
shift `expr $OPTIND - 1`

if [[ ${hosts_list} == "yes" ]]; then
    vhosts=($(cat "${list}" | cut -d/ -f2))
else
    if [[ ${config_isremote} == "yes" ]]; then
        use_intermediary="yes"
        intermediary="${config_host}"
        vhosts=($(ssh -qt ${config_host} "configs=\$(grep -l ServerName /etc/httpd/conf.vhosts.d/*.conf); awk 'BEGIN { FS=\"[:>]\"} /VirtualHost*/ { port=\$2 } /^[^#]*ServerName*/ { split(\$0, url, \" \" seps); print url[2] \":\" port } END { }' \${configs}" | sort -u))
    else
        if [[ -f "${config_location}" ]]; then
            configs="${config_location}"
        elif [[ -d "${config_location}" ]]; then
            configs=$(grep -l ServerName ${config_location}/*.conf)
            if [[ -z ${configs} ]]; then
                echo "No valid configurations found!"
                exit 1
            fi
        else
            echo "The specified configuration location must be either a regular file or directory."
            exit 1
        fi
        vhosts=($(awk 'BEGIN { FS="[:>]" } /VirtualHost*/ { port=$2 } /^[^#]*ServerName*/ { split($0, url, " " seps); print url[2] ":" port } END { }' ${configs} | sort -u))
    fi
fi

if [[ ! ${dump_host} == "yes" ]]; then
    echo "Apache Virtual Host Verification"
    echo "--------------------------------"
    echo "Load from hosts file: ${hosts_list}"
    [[ ${hosts_list} == "yes" ]] && echo "Host file: ${list}"
    echo "Using remote configuration: ${config_isremote}"
    [[ ${config_isremote} == "yes" ]] && echo "Remote configuration host: ${config_host}"
    echo "Config location: ${config_location}"
    echo "Use Intermediary: ${use_intermediary}"
    [[ ${use_intermediary} == "yes" ]] && echo "Intermediare/Proxy host: ${intermediary}"
    echo "Ignore Host Port: ${ignore_host_port}"
    echo "Open in Browser: ${open_in_browser}"
    echo
fi

if [[ ${open_in_browser} == "yes" ]]; then
    ssh -D 1080 -f -C -q -N ${intermediary} 
fi

for host in ${vhosts[@]}; do
    host_name="${host%%\:*}"
    host_port=":${host##*\:}"

    host_name=$(tr -dc '[[:print:]]' <<< "${host_name}")
    host_port=$(tr -dc '[[:print:]]' <<< "${host_port}")

    [[ ${ignore_host_port} == "yes" || ${host_port} == "80" ]] && host_port=""
    host_url="http://${host_name}"
    host_urlp="http://${host_name}${host_port}"

    if [[ ${list_hosts} == "yes" ]]; then
        echo "${host_urlp}"
    else
        if [[ ${use_intermediary} == "yes" ]]; then
            host_urlp="http://${intermediary}${host_port}"
        fi

        curl_cmd="curl -s ${host_urlp} -I -H \"Host: ${host_name}\" -L --connect-timeout 10"
        response=($(${curl_cmd} | grep 'HTTP' | tail -n1))
        httpcode="${response[1]}"
        httptext="${response[@]:2}"

        if [[ ${httpcode} =~ (200|201|202) ]]; then
            clr=$'\e[32m'
        elif [[ ${httpcode} =~ (301|302|401|402|403) ]]; then
            clr=$'\e[33m'
        else
            clr=$'\e[31m'
        fi

        response="${clr}[${httpcode}] $httptext${noclr}"
#        printf "%s %s %s\n" ${host_name} ${runner:${#host_name}} ${response}
        echo "${host_name} ${runner:${#host_name}} ${response}"

        if [[ ${open_in_browser} == "yes" ]]; then
            "/C/Program Files (x86)/Google/Chrome/Application/chrome.exe" --proxy-server=localhost:1080 ${host_url}
            read -t 1
        fi
    fi
done
echo
echo "${#vhosts[@]} virtual hosts."


