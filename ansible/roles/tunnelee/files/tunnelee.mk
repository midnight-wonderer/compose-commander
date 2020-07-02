SHELL:=/usr/bin/env bash
SOURCE_DIR=$(strip $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST)))))
PSK=$(shell cat $(SOURCE_DIR)/psk | xargs)
SOCKS_SERVER=10.0.0.1

.PHONY: redirect-socks redirect-shadowsocks

redirect-socks:
	$(SOURCE_DIR)/bin/gost -L=redirect://:12345 -F=socks://$(SOCKS_SERVER):1080

redirect-shadowsocks:
	$(SOURCE_DIR)/bin/shadowsocks2 -c "ss://AEAD_AES_128_GCM:$(PSK)@:48488" -redir :12345

nat:
	sudo iptables -t nat -N REDIRECT_SOCKS && \
	true && \
	echo "Ignore LANs and some other reserved addresses." > /dev/null && \
	echo "See http://en.wikipedia.org/wiki/Reserved_IP_addresses#Reserved_IPv4_addresses" > /dev/null && \
	echo "and http://tools.ietf.org/html/rfc5735 for full list of reserved networks." > /dev/null && \
	sudo iptables -t nat -A REDIRECT_SOCKS -d 0.0.0.0/8 -j RETURN && \
	sudo iptables -t nat -A REDIRECT_SOCKS -d 10.0.0.0/8 -j RETURN && \
	sudo iptables -t nat -A REDIRECT_SOCKS -d 100.64.0.0/10 -j RETURN && \
	sudo iptables -t nat -A REDIRECT_SOCKS -d 127.0.0.0/8 -j RETURN && \
	sudo iptables -t nat -A REDIRECT_SOCKS -d 169.254.0.0/16 -j RETURN && \
	sudo iptables -t nat -A REDIRECT_SOCKS -d 172.16.0.0/12 -j RETURN && \
	sudo iptables -t nat -A REDIRECT_SOCKS -d 192.168.0.0/16 -j RETURN && \
	sudo iptables -t nat -A REDIRECT_SOCKS -d 198.18.0.0/15 -j RETURN && \
	sudo iptables -t nat -A REDIRECT_SOCKS -d 224.0.0.0/4 -j RETURN && \
	sudo iptables -t nat -A REDIRECT_SOCKS -d 240.0.0.0/4 -j RETURN && \
	true && \
	echo "AWS quirk" > /dev/null && \
	sudo iptables -t nat -A REDIRECT_SOCKS -d $(SOCKS_SERVER) -j RETURN && \
	true && \
	echo "Anything else should be redirected to port 12345" > /dev/null && \
	sudo iptables -t nat -A REDIRECT_SOCKS -p tcp -j REDIRECT --to-ports 12345 && \
	sudo iptables -t nat -A OUTPUT -p tcp -j REDIRECT_SOCKS
