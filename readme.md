## Ambientum
Keeping it uniform between development, staging and production environments is often something not easy. On the last years, our buddy Docker has becoming more and more mature and now it's becoming the standard.

We all love Laravel and Vue.js, but why develop a rockstar code with a kickass framework without a awesome environment? no more "it worked on my machine"!

### TL;DR
If you're something like me, you don't have all the patience of reading documentations fully, so here are the supported images and they matching docker-compose entries. Although We highly recommend you to read the whole Wiki [WIP].

### Documentation / Tutorials
All you need to know in order to create and maintain your environment is on our Wiki (@todo create wiki and update link here)

> We expect to release a config generator supporting both docker-compose, docker cloud (formerly Tutum) and Rancher real soon.



|Repository                | Images/Tags                   | Description                                        |
|--------------------------|-------------------------------|----------------------------------------------------|
| ambientum/**php**        | `7.0`, `latest`               | PHP v7.0 for command line and queues               |
|                          | `7.0-apache`, `latest-apache` | PHP v7.0 with Apache webserver                     |
|                          | `7.0-caddy`, `latest-caddy`   | PHP v7.0 with Caddy webserver                      |
|                          | `7.0-nginx`, `latest-nginx`   | PHP v7.0 with Nginx webserver                      |
| ambientum/**mysql**      | `5.7`, `latest`               | MySQL Server v5.7 (with sql-mode='')               |
|                          | `5.6`                         | MySQL Server v5.6                                  |
|                          | `5.5`                         | MySQL Server v5.5                                  |
| ambientum/**mariadb**    | `10.1`, `latest`              | MariaDB Server v10.1                               |
|                          | `10.0`                        | MariaDB Server v10.0                               |
|                          | `5.5`                         | MariaDB Server v5.5                                |
| ambientum/**postgres**  | `9.6`, `latest`               | PostgreSQL Server v9.6                             |
|                          | `9.5`         `               | PostgreSQL Server v9.5                             |
|                          | `9.4`         `               | PostgreSQL Server v9.4                             |
|                          | `9.3`                         | PostgreSQL Server v9.3                             |
| ambientum/**redis**      | `3.2`, `latest`               | Redis Server v3.2                                  |
|                          | `3.0`                         | Redis Server v3.0                                  |
| ambientum/**node**       | `6`, `latest`                 | Node.js v6.x                                       |
| ambientum/**vue-cli**    | `2.2`, `latest`               | Vue-cli v2.2.x                                     |
|                          | `2.1`                         | Vue-cli v2.1.x                                     |
|                          | `2.0`                         | Vue-cli v2.0.x                                     |
|                          | `1.3`                         | Vue-cli v1.3.x                                     |
| ambientum/**gulp-cli**   | `1.2`, `latest`               | Gulp-cli v1.2.x                                    |
|                          | `2.1`                         | Gulp-cli v1.1.x                                    |

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

####For Bash ans ZSH Users:
```
curl -L https://github.com/codecasts/ambientum/raw/master/commands.bash -o ~/.ambientum_rc
source ~/.ambientum_rc
```

####For Fish users:
```
curl -L https://github.com/codecasts/ambientum/raw/master/commands.fish -o ~/.ambientum_rc
source ~/.ambientum_rc
```

### I do have a project, and i want to run it using docker
Well, that's the whole point of the project, the commands there was designed for quck usage of stand alone commands, so we have a great alternative when we have a project already, we can define a docker-compose.yml file that will expose and run the services we need.

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
  # MySQL Data
  sandbox-mysql-data:
    driver: local

  # Redis Data
  sandbox-redis-data:
    driver: local

services:
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
Developing with Vue.js? we got you covered, here is the docker-compose file:

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
