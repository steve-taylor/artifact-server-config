# Artifact Server on RancherOS

This repo contains a script that generates a cloud-config.yml file to
provision an artifact server with the following services:

* Docker Registry
* npm registry (Verdaccio)
* Maven repository (Artifactory OSS)

All services are secured by TLS with Lets Encrypt certificates that
automatically renew on a monthly basis.

This has been tested on [DigitalOcean](https://m.do.co/c/11e0789c0a91)
*(referral link)*.

## Requirements

* `bash` shell
* `envsubst`

## Instructions

1. Run the following command, substituting variables as required:
   ```sh
   DOMAIN_ADMIN_EMAIL=admin@example.com \
   REGISTRY_DOMAIN=docker.example.com \
   REGISTRY_USER=me \
   ARTIFACTORY_DOMAIN=maven.example.com \
   VERDACCIO_DOMAIN=npm.example.com \
   VERDACCIO_USER=me \
   STAGING=1 \                             # set to 0 (or remove) in production
   ./generate-cloud-config.sh
   ```
2. Reserve an IP address for your server.
3. Create DNS records for all domains specified in step 1, pointing them to
   the reserved IP address.
4. Provision a RancherOS server on the reserved IP address and using the
   generated cloud-config.yml file.

**Important:** Lets Encrypt requires that DNS records are accurate, therefore
your reserved IP address (to which all your subdomains' DNS records point) must
be associated with your server.  If you cannot assign the reserved IP address
to the server before it is created, you have a bit of time after the server is
created, while Docker is downloading images for the first time.

## Lets Encrypt rate limits

Lets Encrypt has very tight rate limits, so its not suitable for development
environment. Fortunately, Lets Encrypt has a staging environment. To generate
certificates in the staging environment, set `STAGING` to `1`. When you are
ready to move to production, set `STAGING` to `0` or remove it entirely.
