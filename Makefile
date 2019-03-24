SHELL=/usr/bin/env bash

.PHONY: ansible-shell cleanup

ansible-shell:
	(docker-compose run --rm ansible bash) || true

cleanup:
	rm ./ansible/*.retry
