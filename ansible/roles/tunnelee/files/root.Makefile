SHELL:=/usr/bin/env bash
SOURCE_DIR=$(strip $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST)))))

nat:
	/sbin/iptables -t nat -N REDIRECT_SOCKS && \
	true && \
	echo "Ignore LANs and some other reserved addresses." > /dev/null && \
	echo "See http://en.wikipedia.org/wiki/Reserved_IP_addresses#Reserved_IPv4_addresses" > /dev/null && \
	echo "and http://tools.ietf.org/html/rfc5735 for full list of reserved networks." > /dev/null && \
	/sbin/iptables -t nat -A REDIRECT_SOCKS -d 0.0.0.0/8 -j RETURN && \
	/sbin/iptables -t nat -A REDIRECT_SOCKS -d 10.0.0.0/8 -j RETURN && \
	/sbin/iptables -t nat -A REDIRECT_SOCKS -d 100.64.0.0/10 -j RETURN && \
	/sbin/iptables -t nat -A REDIRECT_SOCKS -d 127.0.0.0/8 -j RETURN && \
	/sbin/iptables -t nat -A REDIRECT_SOCKS -d 169.254.0.0/16 -j RETURN && \
	/sbin/iptables -t nat -A REDIRECT_SOCKS -d 172.16.0.0/12 -j RETURN && \
	/sbin/iptables -t nat -A REDIRECT_SOCKS -d 192.168.0.0/16 -j RETURN && \
	/sbin/iptables -t nat -A REDIRECT_SOCKS -d 198.18.0.0/15 -j RETURN && \
	/sbin/iptables -t nat -A REDIRECT_SOCKS -d 224.0.0.0/4 -j RETURN && \
	/sbin/iptables -t nat -A REDIRECT_SOCKS -d 240.0.0.0/4 -j RETURN && \
	true && \
	echo "AWS quirk" > /dev/null && \
	/sbin/iptables -t nat -A REDIRECT_SOCKS -d 172.0.0.0/10 -j RETURN && \
	true && \
	echo "Anything else should be redirected to port 12345" > /dev/null && \
	/sbin/iptables -t nat -A REDIRECT_SOCKS -p tcp -j REDIRECT --to-ports 12345 && \
	/sbin/iptables -t nat -A OUTPUT -p tcp -j REDIRECT_SOCKS
