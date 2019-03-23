SHELL=/usr/bin/env bash

.PHONY: ping

ping:
	ANSIBLE_HOST_KEY_CHECKING=false ansible uninitialized -m ping --extra-vars "ansible_python_interpreter=\"/usr/bin/env python3\""

setup:
	ANSIBLE_HOST_KEY_CHECKING=false ansible-playbook setup.yml

harden:
	ANSIBLE_HOST_KEY_CHECKING=false ansible-playbook harden.yml
