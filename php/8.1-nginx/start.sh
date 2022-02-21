#!/bin/bash

if /usr/bin/find '/scripts/' -mindepth 1 -maxdepth 1 -type f -print -quit 2>/dev/null | read v
then
	echo '/scripts is not empty attempting to  perform configuration'
	echo 'looking for shell scripts in /scripts'
	find '/scripts/' -follow -type f -print | sort -V | while read -r f
	do
		case "$f" in
			*.sh)
				if [ -x "$f" ];
				then
					echo "Launching $f";
					"$f"
				else
					# warn on scripts which are not executasble
					echo "Ignoring $f, not executable"
				fi
				;;
			*) echo "Ingnoring $f";;
		esac
	done
	echo 'Configuration complete ready for startup'
else
	echo 'No files found in /scripts, skipping configuration'
fi

sudo ln -s /etc/nginx/sites/$FRAMEWORK.conf /etc/nginx/sites/enabled.conf

# Starts FPM
nohup /usr/sbin/php-fpm8 -y /etc/php8/php-fpm.conf -F -O > /dev/null 2>&1 &

# Starts NGINX!
nginx
