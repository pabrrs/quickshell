build:
	shc -f quickshell.sh -o bin/quickshell
	rm quickshell.sh.x.c

install:
	chmod +x ./bin/quickshell
	ln -sf "${PWD}/bin/quickshell" /usr/local/bin/quickshell