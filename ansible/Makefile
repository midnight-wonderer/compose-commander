SHELL:=/usr/bin/env bash
ANSIBLE_HOST_KEY_CHECKING:=false
SOURCE_DIR=$(strip $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST)))))
GOST_VERSION=2.11.1
SHADOWSOCKS_VERSION=v0.1.0

.PHONY: ping

ping:
	ansible uninitialized -m ping --extra-vars "ansible_python_interpreter=\"/usr/bin/env python3\""

harden:
	ansible-playbook harden.yml

composable:
	ansible-playbook composable.yml

runner:
	ansible-playbook runner.yml

http-gears:
	ansible-playbook http-gears.yml

http-proxy:
	ansible-playbook http-proxy.yml

http-config:
	echo "TODO: check nginx config and reload"

reboot:
	(ansible worker -m reboot -a "reboot_timeout=0" --extra-vars "ansible_python_interpreter=\"/usr/bin/env python3\"") || true

update:
	(ansible worker -m apt -a "name=* state=latest update_cache=yes" --extra-vars "ansible_python_interpreter=\"/usr/bin/env python3\"") || true

aws-harden:
	(ansible worker -m user -a "name=ubuntu state=absent remove=yes" --extra-vars "ansible_python_interpreter=\"/usr/bin/env python3\"") || true

fix-key-permission:
	chmod 0600 ./keys/id_ed25519 ./keys/*.pem

letsencrypt:
	echo "\"make http-gears\", run \"sudo certbot --nginx\" on the server, and examine nginx config file changes"

cleanup:
	rm ./*.retry

download-gost:
	if [ ! -f "$(SOURCE_DIR)/bin/gost" ]; then \
		URL="https://github.com/ginuerzh/gost/releases/download/v$(GOST_VERSION)/gost-linux-amd64-$(GOST_VERSION).gz" && \
		((curl -s -L $$URL | gunzip -q) > "$(SOURCE_DIR)/bin/gost") && \
		(chmod +x "$(SOURCE_DIR)/bin/gost") \
	fi

download-shadowsocks:
	if [ ! -f "$(SOURCE_DIR)/bin/shadowsocks2" ]; then \
		URL="https://github.com/shadowsocks/go-shadowsocks2/releases/download/$(SHADOWSOCKS_VERSION)/shadowsocks2-linux.gz" && \
		((curl -s -L $$URL | gunzip -q) > "$(SOURCE_DIR)/bin/shadowsocks2") && \
		(chmod +x "$(SOURCE_DIR)/bin/shadowsocks2") \
	fi

ssh-locker:
	ansible-playbook ssh-locker.yml && \
	echo "Don't forget to config variables in Makefile and add some cronjob"

tunneler: download-gost download-shadowsocks
	ansible-playbook tunneler.yml && \
	echo "Don't forget to config variables in Makefile and add some cronjob"

tunnelee: download-gost download-shadowsocks
	ansible-playbook tunnelee.yml && \
	echo "Don't forget to config variables in Makefile and add some cronjob"
