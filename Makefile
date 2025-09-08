install:
	chmod +x quickshell.sh
	ln -sf "${PWD}/quickshell.sh" /usr/local/bin/quickshell
	ln -sf "${PWD}/quickshell.sh" /usr/local/bin/qsh
	
	@echo ""
	@echo "⚡️ quickshell ⚡️"
	@echo "	 Installation finished."
	@echo "	 Please close and reopen your terminal."
	@echo "	 Run 'qsh --help' to verify the installation."
	@echo ""

uninstall:
	rm -f /usr/local/bin/quickshell /usr/local/bin/qsh ~/.quickshell
