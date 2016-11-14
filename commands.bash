# Where the ambientum cache will live
export A_CACHE_HOME=$HOME/.cache/ambientum

# Define specific cache directories
A_NPM_CONFIG=$A_CACHE_HOME/npm-config
A_NPM_CACHE=$A_CACHE_HOME/npm-cache
A_COMPOSER_CACHE=$A_CACHE_HOME/composer
A_YARN_BIN=$A_CACHE_HOME/yarn/bin
A_YARN_CONFIG=$A_CACHE_HOME/yarn/config
A_YARN_CACHE=$A_CACHE_HOME/yarn/cache

# Create directories
mkdir -p $A_CACHE_HOME
mkdir -p $A_NPM_CONFIG
mkdir -p $A_NPM_CACHE
mkdir -p $A_COMPOSER_CACHE
mkdir -p $A_YARN_BIN
mkdir -p $A_YARN_CONFIG
mkdir -p $A_YARN_CACHE

# When using private projects, a SSH Key may be needed
# this line will provide your user ssh key
A_SSH_HOME=$HOME/.ssh

###########################################
#### DO NOT EDIT BELOW THIS LINE UNLESS   #
#### YOU KNOW WHAT YOU'RE DOING           #
###########################################

# Mount for SSH Directories
A_SSH_NODE_MOUNT=$A_SSH_HOME:/home/node-user/.ssh
A_SSH_PHP_MOUNT=$A_SSH_HOME:/home/php-user/.ssh

# Mount for cache
A_NPM_CONFIG_MOUNT=$A_NPM_CONFIG:/home/node-user/.npm-packages
A_NPM_CACHE_MOUNT=$A_NPM_CACHE:/home/node-user/.npm
A_COMPOSER_MOUNT=$A_COMPOSER_CACHE:/home/php-user/.composer
A_YARN_BIN_MOUNT=$A_YARN_BIN:/home/node-user/.local/bin
A_YARN_CONFIG_MOUNT=$A_YARN_CONFIG:/home/node-user/.yarn-config
A_YARN_CACHE_MOUNT=$A_YARN_CACHE:/home/node-user/.yarn-cache

####
# Alias for NPM And other node commands
####

# Node Env
function n() {
	docker run -it --rm -v $(pwd):/var/www/app -v $A_NPM_CACHE_MOUNT -v $A_YARN_BIN_MOUNT -v $A_YARN_CONFIG_MOUNT -v $A_YARN_CACHE_MOUNT -v $A_NPM_CONFIG_MOUNT -v $A_SSH_NODE_MOUNT ambientum/node:6 "$@"
}
alias n=n

# PHP Env
function p() {
	docker run -it --rm -v $(pwd):/var/www/app -v $A_COMPOSER_MOUNT -v $A_SSH_PHP_MOUNT ambientum/php:7.0 "$@"
}
alias p=p