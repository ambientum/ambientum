![Readme Art](https://raw.githubusercontent.com/ambientum/ambientum/master/new-readme-art.png)

# Ambientum

[![Build Status](https://travis-ci.org/ambientum/ambientum.svg?branch=master)](https://travis-ci.org/ambientum/ambientum)
[![npm version](https://badge.fury.io/js/%40ambientum%2Fcli.svg)](https://badge.fury.io/js/%40ambientum%2Fcli)
[![Known Vulnerabilities](https://snyk.io/test/github/ambientum/cli/badge.svg?targetFile=package.json)](https://snyk.io/test/github/ambientum/cli?targetFile=package.json)

Keeping it uniform between development, staging and production environments is often something not easy.
On the last years, our buddy Docker has become more and more mature and now it's becoming the standard.

We all love Laravel and Vue.JS, but why develop a Rock Star code with a Kick-Ass framework
without an awesome environment?

No more "it worked on my machine"!

## What is does?
Ambientum can help you doing some amazing things, the 3 main scenarios are listed above:

- **Run Laravel and/or Vue.JS in Development.**
- **Run Laravel and/or Vue.JS in Production (Continuous Integration included).**
- **Replace local dependencies with Docker commands.**

## What do I need to know before getting started?

Before staging with Ambientum, a few pieces of knowledge must be in place:

#### For replacing local commands:
- The basics of Docker and Containers.
- Being comfortable around the command line.

#### For running a development Laravel or Vue.JS environment:
- Know how to operate `docker-compose`.


## Notice
Docker compose shipped with Docker is usually very old.
Please have the latest version installed from Github at https://github.com/docker/compose/releases.

## Images
If you are already comfortable with the tools and have played around Ambientum, here are the set of images available for usage,
so you can start building your environment with the tools that you may want.

|Repository                 | Images/Tags                   | Description                                        |
|---------------------------|-------------------------------|----------------------------------------------------|
| ambientum/**php**         | `8.0`, `latest`               | PHP v8.0 for command line and queues               |
|                           | `8.0-nginx`, `latest-nginx`   | PHP v8.0 with Nginx web server                     |
|                           | `7.4`                         | PHP v7.4 for command line and queues               |
|                           | `7.4-nginx`                   | PHP v7.4 with Nginx web server                     |
|                           | `7.3`                         | PHP v7.3 for command line and queues               |
|                           | `7.3-nginx`                   | PHP v7.3 with Nginx web server                     |
|                           | `7.2`                         | PHP v7.2 for command line and queues               |
|                           | `7.2-nginx`                   | PHP v7.2 with Nginx web server                     |
|                           | `7.1`                         | PHP v7.1 for command line and queues               |
|                           | `7.1-nginx`                   | PHP v7.1 with Nginx web server                     |
| ambientum/**node**        | `15`, `latest`, `current`     | Node.js CURRENT (v11.x)                            |
|                           | `14`, `lts`                   | Node.js LTS (v10.x)                                |
|                           | `13`, `12`, `11`, `10`        | Node.js previous versions                          |

## Quick usage guide

### Replacing local commands:

With Ambientum, you may replace local Node.JS and PHP installations.

That's due usage of [Ambientum/CLI](https://github.com/ambientum/cli)


#### Installing **Ambientum CLI**:

Option 1: Using a locally installed NPM.
```
npm -g install @ambientum/cli
```

Option 2: Using pre-built binaries at https://github.com/ambientum/cli/releases/tag/0.1.1:

```
curl -L https://github.com/ambientum/cli/releases/download/0.1.1/amb-`uname -s` -o /usr/local/bin/amb
chmod +x /usr/local/bin/amb
```


#### Usage

Everything Node.JS related can be executed by `amb -n`.

```
amb -n npm -g install @vue/cli
amb -n vue create my-project
```

Everything PHP related can be executed by `amb -p `.

```
amb -p composer create laravel/laravel my-project
```

Or even run php against a single file:
```
amb -p php test.php
```

### Running Projects

In order to use those images, you may use manually docker-compose.yml creation, or use `amb` to generate for you!

```shell
amb init
```