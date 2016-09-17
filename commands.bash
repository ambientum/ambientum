
# Versions

# Where the ambientum cache will live
A_CACHE_HOME=$HOME/.cache/ambientum

# Define specific cache directories
A_NPM_CONFIG=$A_CACHE_HOME/npm-config
A_NPM_CACHE=$A_CACHE_HOME/npm-cache
A_COMPOSER_CACHE=$A_CACHE_HOME/composer

# When using private projects, a SSH Key may be needed
# this line will provide your user ssh key
A_SSH_HOME=$HOME/.ssh

###########################################
#### DO NOT EDIT BELOW THIS LINE UNLES    #
#### YOU KNOW WHAT YOU'RE DOING           #
###########################################

# Mount for SSH Directories
A_SSH_NODE_MOUNT=$A_SSH_HOME:/home/node-user/.ssh
A_SSH_PHP_MOUNT=$A_SSH_HOME:/home/php-user/.ssh

# Mount for Application
A_APP_MOUNT=$(pwd):/var/www/app 

# Mount for cache
A_NPM_CONFIG_MOUNT=$A_NPM_CONFIG:/home/node-user/.npm-packages
A_NPM_CACHE_MOUNT=$A_NPM_CACHE:/home/node-user/.npm
A_COMPOSER_MOUNT=$A_COMPOSER_CACHE:/home/php-user/.composer

# Create directories
mkdir -p $A_CACHE_HOME
mkdir -p $A_NPM_CACHE
mkdir -p $A_NPM_CONFIG
mkdir -p $A_COMPOSER_CACHE

####
# Alias for NPM And other node commands
####

function ane() {
	docker run -it --rm -v $(pwd):/var/www/app -v $A_NPM_CACHE_MOUNT -v $A_NPM_CONFIG_MOUNT -v $A_SSH_NODE_MOUNT ambientum/node:6 "$@"
}
alias ane=ane

function ape() {
	docker run -it --rm -v $(pwd):/var/www/app -v $A_COMPOSER_MOUNT -v $A_SSH_PHP_MOUNT ambientum/php:7.0 "$@"
}
alias ape=ape

# Node
function node() {
	docker run -it --rm -v $(pwd):/var/www/app -v $A_NPM_CACHE_MOUNT -v $A_NPM_CONFIG_MOUNT -v $A_SSH_NODE_MOUNT ambientum/node:6 node "$@"
}
alias node=node

# NPM
function npm() {
	docker run -it --rm -v $(pwd):/var/www/app -v $A_NPM_CACHE_MOUNT -v $A_NPM_CONFIG_MOUNT -v $A_SSH_NODE_MOUNT ambientum/node:6 npm "$@"
}
alias npm=npm

# Gulp
function gulp() {
	docker run -it --rm -v $(pwd):/var/www/app -v $A_NPM_CACHE_MOUNT -v $A_SSH_NODE_MOUNT ambientum/gulp-cli:1.2 gulp "$@"
}
alias gulp=gulp

# Vue
function vue() {
	docker run -it --rm -v $(pwd):/var/www/app -v $A_NPM_CACHE_MOUNT -v $A_SSH_NODE_MOUNT ambientum/vue-cli:2.2 vue "$@"
}
alias vue=vue

####
# Alias for Composer and other PHP commands
####

# PHP
function php() {
	docker run -it --rm -v $(pwd):/var/www/app -v $A_COMPOSER_MOUNT -v $A_SSH_PHP_MOUNT ambientum/php:7.0 php "$@"
}
alias php=php

# Composer
function composer() {
	docker run -it --rm -v $(pwd):/var/www/app -v $A_COMPOSER_MOUNT -v $A_SSH_PHP_MOUNT ambientum/php:7.0 composer "$@"
}
alias composer=composer
