# where the ambientum cache will live
set	A_BASE		$HOME/.cache/ambientum

# define specific cache directories
set	A_CONFIG    $A_BASE/.config
set	A_CACHE	    $A_BASE/.cache
set	A_LOCAL	    $A_BASE/.local
set A_SSH		$HOME/.ssh
set A_COMPOSER  $A_BASE/.composer

# create directories
mkdir -p $A_CONFIG
mkdir -p $A_CACHE
mkdir -p $A_LOCAL
mkdir -p $A_COMPOSER

###########################################
#### DO NOT EDIT BELOW THIS LINE UNLESS   #
#### YOU KNOW WHAT YOU'RE DOING           #
###########################################

# reset permissions
chown -R (whoami):(id -gn) $A_BASE

# home directory
set A_USER_HOME /home/ambientum


####
# alias for NPM And other node commands
####

# node Env
function n
	docker run -it --rm -v (pwd):/var/www/app \
	-v $A_CONFIG:$A_USER_HOME/.config \
	-v $A_CACHE:$A_USER_HOME/.cache \
	-v $A_LOCAL:$A_USER_HOME/.local \
	-v $A_SSH:$A_USER_HOME/.ssh \
	ambientum/node:9 $argv
end

# php Env
function p
	docker run -it --rm -v (pwd):/var/www/app \
	-v $A_COMPOSER:$A_USER_HOME/.composer \
	-v $A_CONFIG:$A_USER_HOME/.config \
	-v $A_CACHE:$A_USER_HOME/.cache \
	-v $A_LOCAL:$A_USER_HOME/.local \
	-v $A_SSH:$A_USER_HOME/.ssh \
	ambientum/php:7.2 $argv
end