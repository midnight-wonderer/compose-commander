SHELL:=/usr/bin/env bash
WHITELIST=https://www.cloudflare.com/ips-v4

exec:
	curl --max-time 5 -ss $(WHITELIST) | \
	grep -E "^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+(\/[0-9]+)?$$" | \
	xargs -L 1 -I %CIDR% sudo ufw allow proto tcp from %CIDR% to any port 22 comment 'SSH Locker'

# Instructions
# - edit the WHITELIST variable
# - setup UFW with the Allow All SSH rule
# - setup crontab for this make
# - wait for result
# - remove the Allow All SSH rule

# Cron entries
# @hourly make -f /home/ssh-locker/locker/Makefile exec 2>&1 >> /dev/null
