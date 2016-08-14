## ambientum
Achieving a high level of conformity on development, staging and production environments is often something not easy. On the last years, our buddy Docker has becoming more and more mature and now it's becoming the standard.

We all love Laravel, but why develop a rockstar code with a kickass framework without a awesome environment? no more "it worked on my machine"!

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
| ambientum/**postgresl**  | `9.6`, `latest`               | PostgreSQL Server v9.6                             |
|                          | `9.5`         `               | PostgreSQL Server v9.5                             |
|                          | `9.4`         `               | PostgreSQL Server v9.4                             |
|                          | `9.3`                         | PostgreSQL Server v9.3                             |
| ambientum/**redis**      | `3.2`, `latest`               | Redis Server v3.2                                  |
|                          | `3.0`                         | Redis Server v3.0                                  |
| ambientum/**node**       | `6`, `latest`                 | Node.js v6.x                                       |
| ambientum/**vue-cli**    | `2.1.0`, `latest`             | Vue-cli v2.1.0                                     |
|                          | `2.0.0`                       | Vue-cli v2.0.0                                     |
|                          | `1.3.0`                       | Vue-cli v1.3.0                                     |


### TL;DR
If you're something like me, you don't have all the patience of reading documentations fully, so here are the supported images and they matching docker-compose entries. Although We highly recommend you to read the whole Wiki.
