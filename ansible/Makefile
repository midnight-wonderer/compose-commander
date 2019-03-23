SHELL=/usr/bin/env bash

.PHONY: ping

ping:
	ANSIBLE_HOST_KEY_CHECKING=false ansible uninitialized -m ping --extra-vars "ansible_python_interpreter=\"/usr/bin/env python3\""

harden:
	ANSIBLE_HOST_KEY_CHECKING=false ansible-playbook harden.yml

composable:
	ANSIBLE_HOST_KEY_CHECKING=false ansible-playbook composable.yml

fix-key-permission:
	chmod 0600 ./keys/id_ed25519
