#!/usr/bin/env ash

# source profile always.
source /etc/profile

# make sure custom entry points directory exists:
sudo mkdir -p /scripts/entry.d

# source all .sh files on entry.d directory.
# shellcheck disable=SC2038
find /scripts/entry.d -name '*.sh' | sort | xargs sudo chmod +x
find /scripts/entry.d -name '*.sh' | sort | xargs -I '{}' {}

# run the original command
exec "$@"
