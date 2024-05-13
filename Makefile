build:
	shc -f quickshell.sh -o bin/quickshell
	rm quickshell.sh.x.c

install:
	chmod +x ./bin/quickshell
	ln -sf "${PWD}/bin/quickshell" /usr/local/bin/quickshell
	chmod +x /usr/local/bin/quickshell

uninstall:
	rm -f /usr/local/bin/quickshell ~/.quickshell
