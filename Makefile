SHELL=/usr/bin/env bash

.PHONY: ping ansible-shell

ansible-shell:
	(docker-compose run --rm ansible bash) || true

ping:
	ansible uninitialized -m ping -k -u root
