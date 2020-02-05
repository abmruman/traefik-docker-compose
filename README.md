# traefik-docker-compose

Run traefik:2.1 load balancer and reverse proxy server using docker-compose.

## Instructions

- Copy `env.example` to `.env`

- Change `.env` variable values as needed

- To generate a new `username:password`, use `htpasswd -nb user pass`, then copy user to `DASHBOARD_USER` and pass to `DASHBOARD_PASSWORD` in .env file

- Change any config in `docker-compose.yml` if necessary

- To validate and view the Compose file run `docker-compose config`

- Create a network `doccker network create net` as defined `NETWORK` in .env

- Start the container using `docker-compose up` or `docker-compose up -d`

- Browse to `dashboard.localhost` or the dashboard url you defined (see in .env)

- If you are using localhost, allow the self-signed certificate on your browser (Accept/Proceed in advanced option)

- Login using `user:pass` (or what you have set in `.env` file)

- To stop (`docker-compose stop`) and remove the containers run `docker-compose down`

## Run as a systemctl (linux) service (optional)

- Copy or clone this directory as `/srv/traefik` or you can change `WorkingDirectory=/srv/traefik` to your desired directory in `traefik.service` file (user absolute path only, don't use `$PWD` or relative path).

- Link `traefik.service` file to `/etc/systemd/system/traefik.service` using `sudo ln -s /srv/traefik/traefik.service /etc/systemd/system/traefik.service`

- Reload systemctl daemon using `sudo systemctl daemon-reload`

- To start the service use `sudo systemctl start traefik.service` or `sudo service traefik start`

- To see status of the service use `sudo systemctl status traefik.service` or `sudo service traefik status`

- To restart the service use `sudo systemctl restart traefik.service` or `sudo service traefik restart`

- To stop the service use `sudo systemctl stop traefik.service` or `sudo service traefik stop`

## Træfɪk

![Træfɪk](https://docs.traefik.io/assets/img/traefik.logo.png)

[Træfɪk](https://github.com/containous/traefik) is a modern HTTP reverse proxy and load balancer that makes deploying microservices easy.
Træfik integrates with your existing infrastructure components ([Docker](https://www.docker.com/), [Swarm mode](https://docs.docker.com/engine/swarm/), [Kubernetes](https://kubernetes.io), [Marathon](https://mesosphere.github.io/marathon/), [Consul](https://www.consul.io/), [Etcd](https://coreos.com/etcd/), [Rancher](https://rancher.com), [Amazon ECS](https://aws.amazon.com/ecs), ...) and configures itself automatically and dynamically.
Telling Træfik where your orchestrator is could be the _only_ configuration step you need to do.

## Docker Compose

![Docker Compose](https://raw.githubusercontent.com/docker/compose/master/logo.png "Docker Compose Logo")

[Compose](https://github.com/docker/compose) is a tool for defining and running multi-container Docker applications.
With Compose, you use a Compose file to configure your application's services.
Then, using a single command, you create and start all the services
from your configuration. To learn more about all the features of Compose
see [the list of features](https://github.com/docker/docker.github.io/blob/master/compose/index.md#features).

Compose is great for development, testing, and staging environments, as well as
CI workflows. You can learn more about each case in
[Common Use Cases](https://github.com/docker/docker.github.io/blob/master/compose/index.md#common-use-cases).
