# traefik-docker-compose

Run traefik:2.1 load balancer and reverse proxy server using docker-compose.

## Instructions

1. Copy `env.example` to `.env`
2. Change `.env` variable values as needed
3. To generate a new `username:password`, use `htpasswd -nb user pass`, then copy user to `DASHBOARD_USER` and pass to `DASHBOARD_PASSWORD` in .env file
4. Change `docker-compose.yml` if necessary
5. To validate and view the Compose file run `docker-compose config`
6. Create a network `doccker network create net` as defined `NETWORK` in .env
7. Start the container using `docker-compose up` or `docker-compose up -d`
8. Browse to `dashboard.localhost` or the dashboard url you defined (see in .env)
9. If you are using localhost, allow the self-signed certificate on your browser (Accept/Proceed in advanced option)
10. Login using `user:pass` (or what you have set in `.env` file)
11. To stop (`docker-compose stop`) and remove the containers run `docker-compose down`

## Træfɪk

![](https://docs.traefik.io/assets/img/traefik.logo.png)

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
