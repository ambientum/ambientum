# Ambientum
Keeping it uniform between development, staging and production environments is often something not easy.
On the last years, our buddy Docker has become more and more mature and now it's becoming the standard.

We all love Laravel and Vue.JS, but why develop a Rock Star code with a Kick-Ass framework 
without a awesome environment? 

No more "it worked on my machine"!

## What is does?
Ambientum can help you doing some amazing things, the 3 main scenarios are listed above:

- Run Laravel and/or Vue.JS in Development
- Run Laravel and/orf Vue.JS in Production (Continuous Integration included)
- Replace local dependencies with Docker commands, 

## What do I need to know before getting started?

Before staging with Ambientum, a few pieces of knowledge must be in place:

#### For replacing local commands:
- The basics of Docker and Containers.
- Being comfortable around the command line.

#### For running a development Laravel or Vue.JS environment:
- Know how to operate `docker-compose`

### TL;DR
If you're something like me, you don't have all the patience of reading documentations fully, so here are the supported images and the matching docker-compose entries. Although we highly recommend you to read the whole Wiki [WIP].

### Documentation / Tutorials
All you need to know in order to create and maintain your environment is on our Wiki (@todo create wiki and update link here)

> We expect to release a config generator supporting both docker-compose, docker cloud (formerly Tutum) and Rancher real soon.


### Command Line Or Compose Images

The following image can be used for stand alone commands or
inside a docker-compose.yml file, examples on each one to come...

|Repository                | Images/Tags                   | Description                                        |
|--------------------------|-------------------------------|----------------------------------------------------|


### Compose only images

The following images are useless to run commands, but great for running
as services inside a `docker-compose` environment

|Repository                 | Images/Tags                   | Description                                        |
|---------------------------|-------------------------------|----------------------------------------------------|

| ambientum/**php**         | `7.0`, `latest`               | PHP v7.0 for command line and queues               |
|                           | `7.0-apache`, `latest-apache` | PHP v7.0 with Apache webserver                     |
|                           | `7.0-caddy`, `latest-caddy`   | PHP v7.0 with Caddy webserver                      |
|                           | `7.0-nginx`, `latest-nginx`   | PHP v7.0 with Nginx webserver                      |
| ambientum/**node**        | `6`, `latest`                 | Node.js v6.x                                       |
| ambientum/**mysql**       | `5.7`, `latest`               | MySQL Server v5.7 (with sql-mode='')               |
|                           | `5.6`                         | MySQL Server v5.6                                  |
|                           | `5.5`                         | MySQL Server v5.5                                  |
| ambientum/**mariadb**     | `10.1`, `latest`              | MariaDB Server v10.1                               |
|                           | `10.0`                        | MariaDB Server v10.0                               |
|                           | `5.5`                         | MariaDB Server v5.5                                |
| ambientum/**postgres**    | `9.6`, `latest`               | PostgreSQL Server v9.6                             |
|                           | `9.5`                         | PostgreSQL Server v9.5                             |
|                           | `9.4`                         | PostgreSQL Server v9.4                             |
|                           | `9.3`                         | PostgreSQL Server v9.3                             |
| ambientum/**redis**       | `3.2`, `latest`               | Redis Server v3.2                                  |
|                           | `3.0`                         | Redis Server v3.0                                  |
| ambientum/**beanstalkd**  | `1.10`, `latest`              | Beanstalkd Server v1.10                            |
|                           | `1.9`                         | Beanstalkd Server v1.9                             |
| ambientum/**mailcatcher** | `latest`                      | MailCatcher is a hosted alternative to MailTrap.io |

## Quick usage guide

### Running stand alone commands:
For running stand alone commands like NPM and Composer, you may want to set your environment with function based commands, that runs inside docker:

After sourcing the correct file, the following commands will be available for usage:

- node
- php
- composer
- npm
- gulp
- vue

####For Bash and ZSH Users:
```
curl -L https://github.com/codecasts/ambientum/raw/master/commands.bash -o ~/.ambientum_rc
source ~/.ambientum_rc
```

####For Fish users:
```
curl -L https://github.com/codecasts/ambientum/raw/master/commands.fish -o ~/.ambientum_rc
source ~/.ambientum_rc
```

### I do have a project, and I want to run it using docker
Well, that's the whole point of the project, the commands there was designed for quick usage of stand alone commands, so we have a great alternative when we have a project already, we can define a docker-compose.yml file that will expose and run the services we need.

> **Understanding the docker-compose compose tool is appreciated in order to use the following configuration files.**

#### Laravel docker-compose.yml


```yml
####
# ATENTION:
# Replace all occurences of sandbox with your project's name
####

# v2 sintax
version: '2'

# Named volumes
volumes:
  # Postgres Data
  sandbox-postgres-data:
    driver: local

  # MySQL Data
  sandbox-mysql-data:
    driver: local

  # Redis Data
  sandbox-redis-data:
    driver: local

services:
  # Postgres (9.5)
  postgres:
    image: ambientum/postgres:9.6
    container_name: sandbox-postgres
    volumes:
      - sandbox-postgres-data:/var/lib/postgresql/data
    ports:
      - "5432:5432"
    environment:
      - POSTGRES_PASSWORD=sandbox
      - POSTGRES_DB=sandbox
      - POSTGRES_USER=sandbox

  # MySQL (5.7)
  mysql:
    image: ambientum/mysql:5.7
    container_name: sandbox-mysql
    volumes:
      - sandbox-mysql-data:/var/lib/mysql
    ports:
      - "3306:3306"
    environment:
      - MYSQL_ROOT_PASSWORD=sandbox
      - MYSQL_DATABASE=sandbox
      - MYSQL_USER=sandbox
      - MYSQL_PASSWORD=sandbox

  # Redis
  cache:
    image: ambientum/redis:3.2
    container_name: sandbox-redis
    command: --appendonly yes
    volumes:
      - sandbox-redis-data:/data
    ports:
      - "6379:6379"

  # PHP (with Caddy)
  app:
    image: ambientum/php:7.0-caddy
    container_name: sandbox-app
    volumes:
      - .:/var/www/app
    ports:
      - "80:8080"
    links:
      - postgres
      - mysql
      - cache

  # Laravel Queues
  queue:
    image: ambientum/php:7.0
    container_name: sandbox-queue
    command: php artisan queue:listen
    volumes:
      - .:/var/www/app
    links:
      - mysql
      - cache
```

### Vue.js docker-compose.yml
Developing with Vue.js? We got you covered! Here is the docker-compose file:

```yml
version: '2'

services:
  # Web server - For live reload and development
  # This environment can be used to run npm and node
  # commands as well
  dev:
    image: ambientum/node:6
    container_name: sandbox-vue-dev
    command: npm run dev
    volumes:
      - .:/var/www/app
    ports:
      - 8080:8080

  # Testing dist on a "real" webserver
  production-server:
    image: nginx:stable-alpine
    container_name: sandbox-preview-server
    volumes:
      - ./dist:/usr/share/nginx/html
    ports:
      - 9090:80
```
