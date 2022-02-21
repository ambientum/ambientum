#!/usr/bin/env ash

# create directory and make sure permissions are set.
mkdir -p "${CAROOT}" && chown -R ambientum:ambientum "${CAROOT}"

# set domain as ambientum.local if not set.
SSL_DOMAIN=${SSL_DOMAIN:-ambientum.local}
# set CAROOT if not already.
CAROOT=${CAROOT:-/home/ambientum/.mkcert}

# get last issued domain
SSL_LAST_DOMAIN=$(cat "${CAROOT}/last-domain" 2>/dev/null)

# certificate path.
SSL_PATH_CERT=${SSL_PATH_CERT:-/home/ambientum/.mkcert/ambientum.pem}
# private key path.
SSL_PATH_KEY=${SSL_PATH_KEY:-/home/ambientum/.mkcert/ambientum.key}

# install / trust CA locally.
mkcert -install 2>/dev/null

# Regenerate SSL certificate if different than default one.
if [[ "${SSL_DOMAIN}" != "${SSL_LAST_DOMAIN}" ]]; then
  # generate SSL certificates for $SSL_DOMAIN
  mkcert -cert-file="${SSL_PATH_CERT}" -key-file="${SSL_PATH_KEY}" "${SSL_DOMAIN}"
  # save the issued domain into last-domain file (persisted).
  echo "${SSL_DOMAIN}" > "${CAROOT}/last-domain"
fi

# update ca certificates, without failing.
sudo update-ca-certificates 2>/dev/null || true