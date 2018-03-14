# where the ambientum cache will live
A_BASE=$HOME/.cache/ambientum

# define specific cache directories
A_CONFIG=$A_BASE/.config
A_CACHE=$A_BASE/.cache
A_LOCAL=$A_BASE/.local
A_SSH=$HOME/.ssh
A_COMPOSER=$A_BASE/.composer

# create directories
mkdir -p $A_CONFIG
mkdir -p $A_CACHE
mkdir -p $A_LOCAL
mkdir -p $A_COMPOSER

###########################################
#### DO NOT EDIT BELOW THIS LINE UNLESS   #
#### YOU KNOW WHAT YOU'RE DOING           #
###########################################

function is_macos {
    local uname=$(uname)

    if [ "$uname" = "Darwin" ]; then
        return 0
    else
        return 1
    fi
}

# reset permissions
if is_macos ; then
	chown -R $(whoami):$(groups $(whoami) | cut -d' ' -f1) $A_BASE
else
	chown -R $(whoami):$(whoami) $A_BASE
fi

# home directory
A_USER_HOME=/home/ambientum

####
# Alias for NPM And other node commands
####

# Node Env
function n() {
	docker run -it --rm -v $(pwd):/var/www/app -v $A_CONFIG:$A_USER_HOME/.config -v $A_CACHE:$A_USER_HOME/.cache -v $A_LOCAL:$A_USER_HOME/.local -v $A_SSH:$A_USER_HOME/.ssh ambientum/node:9 "$@"
}
alias n=n

# PHP Env
function p() {
	docker run -it --rm -v $(pwd):/var/www/app -v $A_COMPOSER:$A_USER_HOME/.composer -v $A_CONFIG:$A_USER_HOME/.config -v $A_CACHE:$A_USER_HOME/.cache -v $A_LOCAL:$A_USER_HOME/.local -v $A_SSH:$A_USER_HOME/.ssh ambientum/php:7.2 "$@"
}
alias p=p