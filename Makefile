all: build

build:
	chmod +x ./documatio

link: build
	sudo ln -sf "$(shell pwd)/documatio" /usr/local/bin/documatio

install:
	sudo install documatio /usr/local/bin

uninstall:
	sudo rm /usr/local/bin/documatio