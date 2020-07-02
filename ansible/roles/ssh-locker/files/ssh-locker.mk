SHELL:=/usr/bin/env bash
WHITELIST_SOURCE=https://www.cloudflare.com/ips-v4
WHITELIST=$(shell \
	curl --max-time 5 -ss $(WHITELIST_SOURCE) | \
	grep -E "^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+(\/[0-9]+)?$$" \
)

.PHONY: exec

exec:
	for CIDR in $(WHITELIST); do \
		sudo ufw allow from $$CIDR to any port ssh comment 'SSH Locker'; \
	done

# Instructions
# - edit the WHITELIST_SOURCE variable
# - setup UFW with the Allow All SSH rule
# - setup crontab for this make
# - wait for result
# - remove the Allow All SSH rule

# Cron entries
# @hourly make -f /home/ssh-locker/locker/Makefile exec 2>&1 >> /dev/null
