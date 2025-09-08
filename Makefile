install:
	chmod +x quickshell.sh
	ln -sf "${PWD}/quickshell.sh" /usr/local/bin/quickshell
	ln -sf /usr/local/bin/quickshell /usr/local/bin/qsh

	qsh --help

uninstall:
	rm -f /usr/local/bin/quickshell /usr/local/bin/qsh ~/.quickshell
