#!/usr/bin/env bash

# if the user wants to enable new relic
if [[ $NR_ENABLED == true ]]; then
	# set the new relic key
	sudo sed -i -e "s/"REPLACE_WITH_REAL_KEY"/$NR_LICENSE_KEY/g" /scripts/newrelic.ini
	# set the new relic application name
	sudo sed -i -e "s/PHP Application/$NR_APP_NAME/g" /scripts/newrelic.ini
	# enable new relic for fpm
	sudo cp /scripts/newrelic.ini /etc/php/7.0/fpm/conf.d/newrelic.ini
	# enable new relic for cli
	sudo cp /scripts/newrelic.ini /etc/php/7.0/cli/conf.d/newrelic.ini
fi

# run the original command
exec "$@"
