SHELL=/usr/bin/env bash
ANSIBLE_HOST_KEY_CHECKING:=false

.PHONY: ping

ping:
	ansible uninitialized -m ping --extra-vars "ansible_python_interpreter=\"/usr/bin/env python3\""

harden:
	ansible-playbook harden.yml

composable:
	ansible-playbook composable.yml

http-gears:
	ansible-playbook http-gears.yml

http-config:
	echo "TODO: check nginx config and reload"

reboot:
	(ansible worker -m reboot -a "reboot_timeout=0" --extra-vars "ansible_python_interpreter=\"/usr/bin/env python3\"") || true

update:
	(ansible worker -m apt -a "name=* state=latest update_cache=yes" --extra-vars "ansible_python_interpreter=\"/usr/bin/env python3\"") || true

lightsail-harden:
	(ansible worker -m user -a "name=ubuntu state=absent remove=yes" --extra-vars "ansible_python_interpreter=\"/usr/bin/env python3\"") || true

fix-key-permission:
	chmod 0600 ./keys/id_ed25519 ./keys/*.pem

letsencrypt:
	echo "\"make http-gears\", run \"sudo certbot --nginx\" on the server, and examine nginx config file changes"

cleanup:
	rm ./*.retry
