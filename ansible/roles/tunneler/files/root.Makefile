SHELL:=/usr/bin/env bash
SOURCE_DIR=$(strip $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST)))))
DEFAULT_INTERFACE=$(shell /sbin/route | grep default | grep -Eo "[a-z0-9]+$$")
VPC_CIDR=10.0.0.0/16

nat:
	/sbin/iptables -t nat -A POSTROUTING -o $(DEFAULT_INTERFACE) -s $(VPC_CIDR) -j MASQUERADE
