#!/bin/bash

# set domain as ambientum.local if not set.
SSL_DOMAIN=${SSL_DOMAIN:-ambientum.local}
# set CAROOT if not already.
CAROOT=${CAROOT:-/home/ambientum/.mkcert}

# get last issued domain
SSL_LAST_DOMAIN=$(cat "${CAROOT}/last-domain" 2>/dev/null)

# Regenerate SSL certificate if different than default one.
if [[ "${SSL_DOMAIN}" != "${SSL_LAST_DOMAIN}" ]]; then
  # create directory and make sure permissions are set.
  mkdir -p "${CAROOT}" && chown -R ambientum:ambientum "${CAROOT}"
  # install / trust CA locally.
  mkcert -install
  # generate SSL certificates for $SSL_DOMAIN
  mkcert -cert-file=/home/ambientum/.mkcert/ambientum.pem -key-file=/home/ambientum/.mkcert/ambientum.key "${SSL_DOMAIN}"
  # save the issued domain into last-domain file (persisted).
  echo "${SSL_DOMAIN}" > "${CAROOT}/last-domain"
fi