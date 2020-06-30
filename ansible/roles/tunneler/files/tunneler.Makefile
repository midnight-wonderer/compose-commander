SHELL:=/usr/bin/env bash
SOURCE_DIR=$(strip $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST)))))
PSK=$(shell cat $(SOURCE_DIR)/psk | xargs)
VPC_CIDR=10.0.0.0/16

nat:
	sudo iptables -t nat -A POSTROUTING -s $(VPC_CIDR) -j MASQUERADE

socks:
	$(SOURCE_DIR)/bin/gost -L=:1080

shadowsocks:
	$(SOURCE_DIR)/bin/shadowsocks2 -s "ss://AEAD_AES_128_GCM:$(PSK)@:48488"
