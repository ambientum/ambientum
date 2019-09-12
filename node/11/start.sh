#!/usr/bin/env bash

# fix home directory permissions.
sudo chown -R ambientum:ambientum /home/ambientum

# copy bash config into place.
cp /home/bashrc /home/ambientum/.bashrc

# run the original command
exec "$@"
