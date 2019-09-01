SHELL:=/usr/bin/env bash
SOURCE_DIR=$(strip $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST)))))
PSK=$(shell cat $(SOURCE_DIR)/psk | xargs)
SOCKS_SERVER=10.0.0.1

redirect-socks:
	$(SOURCE_DIR)/bin/gost -L=redirect://:12345 -F=socks://$(SOCKS_SERVER):1080

redirect-shadowsocks:
	$(SOURCE_DIR)/bin/shadowsocks2 -c "ss://AEAD_AES_128_GCM:$(PSK)@:48488" -redir :12345
