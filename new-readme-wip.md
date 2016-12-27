![Readme Art](https://raw.githubusercontent.com/codecasts/ambientum/master/new-readme-art.png)

# Ambientum

Keeping it uniform between development, staging and production environments is often something not easy.
On the last years, our buddy Docker has become more and more mature and now it's becoming the standard.

We all love Laravel, but why develop a Rock Star code with a Kick-Ass framework 
without a awesome environment? 

No more "it worked on my machine"!

## TOC


## Before Starting

Before staging to use it, you should first know that ambientum can be used on 4 distinguish places:

- To **replace** local **PHP** command line tools (Composer and global dependencies included)
- To **replace** local **Node.JS** and node related resources (such as Gulp and NPM/Yarn)
- To run a Laravel project (under Docker-compose)
- To build your projects docker image (locally or on a continuous integration platform).

## Requirements
All you need to run everything, from project creation to production is this:

- Latest version of Docker
- Latest version of docker-compose

## 1) Installing CLI Tools

Instead of installing PHP and/or Node.JS Locally to develop and be able use composer/gulp and other tools.
All you need to do is enable Ambientum commands.

There are two different commands available, `p` and `n` where `p` stands for the PHP environment and `n` for the Node.JS environment

Let's download the script behind the commands and store them into `~/.ambientum_rc`

If your terminal is bash (or if you don't know which terminal you do use):

```
curl -L https://github.com/codecasts/ambientum/raw/master/commands.bash -o ~/.ambientum_rc
```

ONLY if your terminal if Fish
```
curl -L https://github.com/codecasts/ambientum/raw/master/commands.fish -o ~/.ambientum_rc
```

## 2) Enabling the CLI tools
After installing the Ambientum main script into `~/.ambientum_rc` (section 1), you need to enable them.
You can do that by running:

```
source ~/.ambientum_rc
```

You can either do that manually at every new session of your terminal or add them to the end of your terminal init scripts
 (like `~/.bashrc` or `~/.config/fish/config.fish`)

This will enable two commands on your command line, `p` and `n`, which we will dig into on the next sections.

## 3) Working with PHP under Ambientum:
After installing and enabling ambientum commands (section 1 and section 2), you should able to run the following test command:

```
p php --version
```

Notice that anything related to php, should be run using the prefix `p` so you are padding to the docker environment

### 3.1 Using Composer (Project related)
If you need to create a project using composer, or update your dependencies, you can do so by running

```
p composer create sample/project my_project
```

### 3.3 Using Composer (Global dependencies)

If you need to install something globally (like phpunit or php-cs-fixer)

```
p composer global require phpunit/phpunit
```

and after installing it, you can just run it prefixing `p`

```
p phpunit --version
```
