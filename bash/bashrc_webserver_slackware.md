```bash
#!/bin/bash
# Put this in your ~/.bashrc_webserver_slackware then the next 2 lines uncommented in your .bashrc
# eval HOME="~"
# . "${HOME}/.bashrc_webserver_slackware"

webserver_services=( \
	/etc/rc.d/rc.postgresql \
	# /etc/rc.d/rc.mysqld \
	/etc/rc.d/rc.httpd \
)

exit_error=1
exit_success=0

function webserver_chmod() {
	local mode="$1"
	case "${1}" in
		+x|-x)
			for webserver_service in "${webserver_services[@]}" ; do
				if [ "$?" -eq "0" ] ; then sudo chmod ${mode} ${webserver_service} ; fi
			done
			return $?
		;;
		*)
			echo "Usage: ${0} {+x|-x}"
			return ${exit_error}
		;;
	esac
}

function webserver_stop() {
	webserver_chmod "+x" && \
	(
		for webserver_service in "${webserver_services[@]}" ; do
			if [ "$?" -eq "0" ] ; then sudo ${webserver_service} stop ; fi
		done
		return $?
	) && \
	webserver_chmod "-x"

	return $?
}

function webserver_start() {
	webserver_chmod "+x" && \
	(
		for webserver_service in "${webserver_services[@]}" ; do
			if [ "$?" -eq "0" ] ; then sudo ${webserver_service} start ; fi
		done
		return $?
	)

	return $?
}

function webserver_restart() {
	webserver_stop && \
		webserver_start

	return $?
}

function webserver() {
	case "$1" in
		start|stop|restart)
			webserver_${1}
		;;
		*)
			echo "Usage: $0 {start|stop|restart}"
		;;
	esac
}
```