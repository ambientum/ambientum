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

### 3.1) Using Composer (Project related)
If you need to create a project using composer, or update your dependencies, you can do so by running

```
p composer create sample/project my_project
```

### 3.3) Using Composer (Global dependencies)

If you need to install something globally (like phpunit or php-cs-fixer)

```
p composer global require phpunit/phpunit
```

and after installing it, you can just run it prefixing `p`

```
p phpunit --version
```

## 4) Working with Node.JS under Ambientum (Mainly for Elixir)

One of the things about Web Development is that impossible to live without Javascript this days.
Laravel elixir (or any gulp / node related) task can be also done under Ambientum.
You don't need to install Node and Gulp locally, just check the following instructions:

### 4.1) Using NPM and Yarn

You can install you frontend dependencies using the second command ambientum provides: `n`

Let's say we already have a package.json file (Laravel projects usually comes with one), and you now want to install the dependencies:

```
# installing frontend dependencies with NPM
n npm install

# installing frontend dependencies with Yarn
n yarn
```

Let's now add a new dependency:
```
n npm install --save bootstrap-sass
```

### 4.2) Using Global Node Dependencies
If you're using the default Laravel frontend setup, you probably gonna need gulp. You can do that by installing it globally first

```
# installing global gulp with NPM
n npm install -g gulp

# or using Yarn instead of NPM
n yarn global add gulp
```

And then, just run gulp normally (prefixing `n`)

One time compile
```
n gulp 
```

Watch
```
n gulp watch
```

For production
```
n gulp --production
```

** You can use global dependencies normally as on your local system, just don't forget to prepend `n`


#@ 5) Running Laravel projects

For running Laravel projects, some experience with Docker-compose may be required. The following is a sample of all possibilities that Ambientum provides
**You will need to remove the resources that your project does not need** and also **replace all occurrences of `sandbox` with your project's name:

For those who are not that familiar with docker-compose. this file, called docker-compose.yml should be placed on the root folder of our application

docker-compose.yml
```yml
# soon
```

## 5) Ambientum at Production (and Testing / CI)
@todo