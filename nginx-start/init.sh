setup_dns_env_var() {
	if [ -z "$DNS_SERVER" ]; then
	    export DNS_SERVER=`cat /etc/resolv.conf | grep "nameserver " | awk '{print $2}' | tr '\n' ' '`
	    echo "Using system dns server ${DNS_SERVER}"
	else
	    echo "Using user defined dns server: ${DNS_SERVER}"
	fi
}

inject_env_vars() {
	## Replace only specified environment variables in specified file.
	envsubst '${DNS_SERVER},${INDEX_FILE}' < $1 > output.conf
	cp output.conf $1
	echo "This is $1: " && cat $1
}

export INDEX_FILE=index2.html
setup_dns_env_var
inject_env_vars "nginx.conf"
