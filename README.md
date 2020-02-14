# Traefik v2.1 (docker-compose)

[![Build Status](https://travis-ci.com/abmruman/traefik-docker-compose.svg?branch=master)](https://travis-ci.com/abmruman/traefik-docker-compose)
[![GitHub license](https://img.shields.io/github/license/abmruman/traefik-docker-compose)](https://github.com/abmruman/traefik-docker-compose/blob/master/LICENSE)
[![GitHub issues](https://img.shields.io/github/issues/abmruman/traefik-docker-compose)](https://github.com/abmruman/traefik-docker-compose/issues)

Traefik:2.1 load balancer and reverse proxy server using docker-compose. Get SSL/TLS certificates automatically using traefik dynamic configurations. Automatically obtain wildcard/SANs certificates for your domain using traefik (lego) with DNS TXT record propagation.

## Installation

1. Copy `env.example` to `.env`

2. Change `.env` variable values as needed (keep `LOG_LEVEL=DEBUG`)

3. To generate a new `username:password`, use `htpasswd -nb user pass`, then copy user to `DASHBOARD_USER` and pass to `DASHBOARD_PASSWORD` in .env file

4. Change any config in `docker-compose.yml` if necessary

5. To validate and view the Compose file run `docker-compose config`

6. Create a network `sudo doccker network create net` as defined `NETWORK` in .env

7. Create `acme.json` file, `sudo touch acme.json && sudo chmod 600 acme.json`

8. Start the container using `docker-compose up` or `docker-compose up -d`

9. Browse to `dashboard.localhost` or the dashboard url you defined (see in .env)

10. If you are using localhost, allow the self-signed certificate on your browser (Accept/Proceed in advanced option)

11. Login using `user:pass` (or what you have set in `.env` file)

12. To stop (`docker-compose stop`) and remove the containers run `docker-compose down`

**Optionally, you can use the bash scripts in [scripts](/scripts) directory**

### Generate the files needed

```bash
cp env.example .env

touch acme.json
chmod 600 acme.json

touch provider.key
echo "supersecretkey" | tee provider.key
chmod 600 provider.key
```

_Add provider's API token/key to `provider.key` file if you are using DNS challenge._

### Generate a user:password for dashboard authentication

```bash
htpasswd -nb USERNAME PASSWORD
```

_After running this, copy the generated `user:pass` to `.env` file._

### Create Network

_Edit `NETWORK` in `.env` file then run_

```bash
eval $(egrep '^NETWORK' .env | xargs)
docker network create $NETWORK | echo
```

## Widcard/SANs certificate (Letsencrypt)

**To obtain wildcard/SANs certificate, you must have access to your provider's (i.e. digitalocean) dns records with `READ` & `WRITE` permission.**

**Note: Letsencrypt uses [rate limiting](https://letsencrypt.org/docs/rate-limits/), Certificates per Registered Domain (50 per week), to ensure fair usage. So, the `CA_SERVER` is set to `staging` server (gives you a fake certificate issued by `Fake LE Intermediate X1`) in the `env file` so that you dont burn out your limit testing initially. If you don't care about the limit or 50 per week is a lot for you, change it to actual server and roll with it. Otherwise, Change all the config in `.env` file, test using staging server. Then, change it to actual server (commented `CA_SERVER` in env file) when everything is functional.**

Follow the steps below:

1. Follow the [Instructions](#instructions) mentioned at the top of this README until `step 8` (don't run `docker-compose up` yet)

2. Find your provider here: [https://docs.traefik.io/https/acme/#providers](https://docs.traefik.io/https/acme/#providers)

3. Edit `PROVIDER`, `PROVIDER_ENV_FILE`, `PROVIDER_ENV_FILE_VALUE` in `.env` file

4. Store your provider's API key to the file, on host machine, as defined in `PROVIDER_ENV_FILE_VALUE` (i.e. `./provider.key`)

5. If you are using a firewall on your server, You may need to allow incoming traffic over port `53` (_Unconfirmed_)

6. Start using `docker-compose up` (avoid running as daemon `docker-compose up -d` so that we can see the logs in stdout)

7. **Note: It might vary how long it will take to validate dns txt info, for example with digitalocean dns provider it doesnt take very long. If you are using `linode` dns provider (tested on `nanode`), go for a coffee, come back after [10-15 mins](https://community.letsencrypt.org/t/no-txt-record-found-using-linode-dns-plugin/76403)**

8. If the dns propagation validation is successful, you will see `"legolog: [INFO] [domain.tld, *.domain.tld] acme: Validations succeeded; requesting certificates"` in the logs (`docker-compose logs traefik`)

9. Now that you have tested your configuration on `letsencrypt` staging server, stop the `traefik` container (`ctrl+c` if you used `docker-compose up`, `docker-compose down` if you used `docker-compose up -d`)

10. Change the `CA_SERVER` environment variable to the main server in env file (uncomment it)

11. Remove & recreate `acme.json`. `sudo rm acme.json && sudo touch acme.json && sudo chmod 600 acme.json`

12. Run `docker-compose up`

13. You will see `"legolog: [INFO] [domain.tld] Server responded with a certificate."` if successful

14. Browse to your dashboard to make sure if the certificates are working (maybe refresh the page few times with `ctrl + shift + r`)

15. You will see that traefik (lego) has got you a fresh wildcard SSL/TLS certificate (with some manual labor :p) auto-magically!

## Run as a systemctl (linux) service (optional)

- Copy/soft-link this directory as `/srv/traefik` or you can change `WorkingDirectory=/srv/traefik` to your desired directory in `traefik.service` file (user absolute path only, `don not` use `$PWD` or relative path in this file).

- Link `traefik.service` file to `/etc/systemd/system/traefik.service` using `sudo ln -s /srv/traefik/traefik.service /etc/systemd/system/traefik.service`

- Reload systemctl daemon using `sudo systemctl daemon-reload`

- To start the service use `sudo systemctl start traefik.service` or `sudo service traefik start`

- To see status of the service use `sudo systemctl status traefik.service` or `sudo service traefik status`

- To restart the service use `sudo systemctl restart traefik.service` or `sudo service traefik restart`

- To stop the service use `sudo systemctl stop traefik.service` or `sudo service traefik stop`

_After you make sure that your traefik container is running properly, you can run the following to start it as a systemd service._

Inside your `traefik` direcory, run the following:

```bash
docker-compose down
sudo ln -s $(pwd) /srv/traefik
sudo ln -s /srv/traefik/traefik.service /etc/systemd/system/traefik.service
sudo systemctl daemon-reload
sudo systemctl start traefik.service
```

## What is Træfɪk

![Træfɪk](https://docs.traefik.io/assets/img/traefik.logo.png)

[Træfɪk](https://github.com/containous/traefik) is a modern HTTP reverse proxy and load balancer that makes deploying microservices easy.
Træfik integrates with your existing infrastructure components ([Docker](https://www.docker.com/), [Swarm mode](https://docs.docker.com/engine/swarm/), [Kubernetes](https://kubernetes.io), [Marathon](https://mesosphere.github.io/marathon/), [Consul](https://www.consul.io/), [Etcd](https://coreos.com/etcd/), [Rancher](https://rancher.com), [Amazon ECS](https://aws.amazon.com/ecs), ...) and configures itself automatically and dynamically.
Telling Træfik where your orchestrator is could be the _only_ configuration step you need to do.

## What is Docker Compose

![Docker Compose](https://raw.githubusercontent.com/docker/compose/master/logo.png "Docker Compose Logo")

[Compose](https://github.com/docker/compose) is a tool for defining and running multi-container Docker applications.
With Compose, you use a Compose file to configure your application's services.
Then, using a single command, you create and start all the services
from your configuration. To learn more about all the features of Compose
see [the list of features](https://github.com/docker/docker.github.io/blob/master/compose/index.md#features).

Compose is great for development, testing, and staging environments, as well as
CI workflows. You can learn more about each case in
[Common Use Cases](https://github.com/docker/docker.github.io/blob/master/compose/index.md#common-use-cases).

## Contribute

Any contribution to this project is warmly welcomed. I did what I could to cover possible edge cases and make it so that you don't have to edit the compose file if you don't want to, but if you find any weakness or mistake, please let me know.

There are over 50 providers for dns-challenge, I only tested 2 of them.
If you happen to use one of the others, feel free to include them in the environment example file ([env.example](/env.example)) or [compose file](/docker-compose.yml). I will be happy to recieve any PR :)
