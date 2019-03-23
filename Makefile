SHELL=/usr/bin/env bash

.PHONY: ping

ping:
	ansible uninitialized -m ping -k -u root
