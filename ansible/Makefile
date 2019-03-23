SHELL=/usr/bin/env bash

.PHONY: ping

ping:
	ANSIBLE_HOST_KEY_CHECKING=false ansible uninitialized -m ping

setup:
	ANSIBLE_HOST_KEY_CHECKING=false ansible-playbook playbooks/setup.yml
