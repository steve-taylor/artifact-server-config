#!/usr/bin/env bash

vars=( DOMAIN_ADMIN_EMAIL REGISTRY_DOMAIN REGISTRY_USER ARTIFACTORY_DOMAIN VERDACCIO_DOMAIN VERDACCIO_USER )

# Ensure all required environment variables are provided
for var in "${vars[@]}"; do
    if [ -z "$(printenv ${var})" ]; then
        (>&2 echo "Missing environment variables:")
        (>&2 echo)
        for var2 in "${vars[@]}"; do
            if [ -z "$(printenv ${var2})" ]; then
                (>&2 echo " - ${var2}")
            fi
        done
        exit 1
    fi
done

# If STAGING isn't set, set it to 0
if [ -z "${STAGING}" ]; then
    export STAGING=0
fi

read -sp "[Docker registry] Enter a new password for user '${REGISTRY_USER}': " REGISTRY_PASS
echo
export REGISTRY_AUTH_HTPASSWD=$(docker run --rm --entrypoint htpasswd registry:2 -Bbn "${REGISTRY_USER}" "${REGISTRY_PASS}" | head -n 1)

read -sp "[Verdaccio NPM registry] Enter a new password for user '${VERDACCIO_USER}': " VERDACCIO_PASS
echo
export VERDACCIO_AUTH_HTPASSWD=$(docker run --rm --entrypoint htpasswd registry:2 -mbn "${VERDACCIO_USER}" "${VERDACCIO_PASS}" | head -n 1)

# Generate cloud-config.yml by processing the template (cloud-config-template.yml).
echo "#cloud-config" > cloud-config.yml
echo >> cloud-config.yml
echo "# Generated by generate-cloud-config.sh on $(date)" >> cloud-config.yml
echo >> cloud-config.yml
export http_upgrade="\$http_upgrade"
export connection_upgrade="\$connection_upgrade"
envsubst < template.yml | tail -n +2 >> cloud-config.yml
