PREFIX ?= /usr/local
PWD ?= $(shell pwd)
CMD = barhide

.PHONY: install all uninstall update upgrade remove

install:
	install $(CMD).sh ${PREFIX}/bin/$(CMD)

all:
	@echo "\n\033[90mUsage:\033[39m make [command]" \
        "\n                        \033[90m# Command left empty performs install\033[39m" \
	      "\n            uninstall   \033[90m# Removes the script\033[39m" \
	      "\n            update      \033[90m# Updates only the repo\033[39m" \
	      "\n            upgrade     \033[90m# Makes update & install\033[39m" \
	      "\n            remove      \033[90m# Moves to trash or deletes\n"

uninstall:
	rm -f $(PREFIX)/bin/$(CMD)

update:
	git clone --no-checkout https://github.com/artginzburg/$(CMD) ~/$(CMD)/$(CMD).tmp && rm -rf ~/$(CMD)/.git && mv ~/$(CMD)/$(CMD).tmp/.git ~/$(CMD)/ && rmdir ~/$(CMD)/$(CMD).tmp && cd ~/$(CMD) && git reset --hard HEAD

upgrade:
	make update && make

remove:
	mv $(PWD) ~/.Trash/$(CMD) || rm -rf $(PWD)
