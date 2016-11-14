
# Versions

# Where the ambientum cache will live
set	A_CACHE_HOME		$HOME/.cache/ambientum

# Define specific cache directories
set	A_NPM_CONFIG		$A_CACHE_HOME/npm-config
set	A_NPM_CACHE			$A_CACHE_HOME/npm-cache
set	A_COMPOSER_CACHE	$A_CACHE_HOME/composer

# When using private projects, a SSH Key may be needed
# this line will provide your user ssh key
set A_SSH_HOME			$HOME/.ssh

###########################################
#### DO NOT EDIT BELOW THIS LINE UNLESS   #
#### YOU KNOW WHAT YOU'RE DOING           #
###########################################

# Mount for SSH Directories
set	A_SSH_NODE_MOUNT	$A_SSH_HOME:/home/node-user/.ssh
set	A_SSH_PHP_MOUNT		$A_SSH_HOME:/home/php-user/.ssh

# Mount for cache
set	A_NPM_CONFIG_MOUNT	$A_NPM_CONFIG:/home/node-user/.npm-packages
set	A_NPM_CACHE_MOUNT	$A_NPM_CACHE:/home/node-user/.npm
set	A_COMPOSER_MOUNT	$A_COMPOSER_CACHE:/home/php-user/.composer

# Create directories
mkdir -p $A_CACHE_HOME
mkdir -p $A_NPM_CACHE
mkdir -p $A_NPM_CONFIG
mkdir -p $A_COMPOSER_CACHE

####
# Alias for NPM And other node commands
####

# Node Env
function n
	docker run -it --rm -v (pwd):/var/www/app -v $A_NPM_CACHE_MOUNT -v $A_NPM_CONFIG_MOUNT -v $A_SSH_NODE_MOUNT ambientum/node:6 $argv
end

# PHP Env
function p
	docker run -it --rm -v (pwd):/var/www/app -v $A_COMPOSER_MOUNT -v $A_SSH_PHP_MOUNT ambientum/php:7.0 $argv
end

# Node
function node
	n node $argv
end

# NPM
function npm
	n npm $argv
end

# Gulp
function gulp
	docker run -it --rm -v (pwd):/var/www/app -v $A_NPM_CACHE_MOUNT -v $A_SSH_NODE_MOUNT ambientum/gulp-cli:1.2 gulp $argv
end

# Vue
function vue
	docker run -it --rm -v (pwd):/var/www/app -v $A_NPM_CACHE_MOUNT -v $A_SSH_NODE_MOUNT ambientum/vue-cli:2.5 vue $argv
end

####
# Alias for Composer and other PHP commands
####

# PHP
function php
	p php $argv
end

# Composer
function composer
	p composer $argv
end