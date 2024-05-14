install:
	chmod +x quickshell.sh
	ln -sf "${PWD}/quickshell.sh" /usr/local/bin/quickshell
	chmod +x /usr/local/bin/quickshell

uninstall:
	rm -f /usr/local/bin/quickshell ~/.quickshell
