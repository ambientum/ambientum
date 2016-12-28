# Where the ambientum cache will live
$A_CACHE_HOME = "$($ENV:UserProfile)/AppData/Local/ambientum"

# Define specific cache directories
$A_NPM_CONFIG = "$($A_CACHE_HOME)/npm-config"
$A_NPM_CACHE = "$($A_CACHE_HOME)/npm-cache"
$A_COMPOSER_CACHE = "$($A_CACHE_HOME)/composer"
$A_YARN_BIN = "$($A_CACHE_HOME)/yarn/bin"
$A_YARN_CONFIG = "$($A_CACHE_HOME)/yarn/config"
$A_YARN_CACHE = "$($A_CACHE_HOME)/yarn/cache"

# Create directories
mkdir $A_CACHE_HOME -ErrorAction:SilentlyContinue | Out-Null
mkdir $A_NPM_CONFIG -ErrorAction:SilentlyContinue | Out-Null
mkdir $A_NPM_CACHE -ErrorAction:SilentlyContinue | Out-Null
mkdir $A_COMPOSER_CACHE -ErrorAction:SilentlyContinue | Out-Null
mkdir $A_YARN_BIN -ErrorAction:SilentlyContinue | Out-Null
mkdir $A_YARN_CONFIG -ErrorAction:SilentlyContinue | Out-Null
mkdir $A_YARN_CACHE -ErrorAction:SilentlyContinue | Out-Null

# When using private projects, a SSH Key may be needed
# this line will provide your user ssh key
$A_SSH_HOME = "$($ENV:UserProfile)/.ssh"

###########################################
#### DO NOT EDIT BELOW THIS LINE UNLESS   #
#### YOU KNOW WHAT YOU'RE DOING           #
###########################################

#reset permissions
icacls $A_CACHE_HOME /t /q /grant "$($ENV:UserName):f" | Out-Null

# Mount for SSH Directories
$A_SSH_NODE_MOUNT = "$($A_SSH_HOME):/home/node-user/.ssh"
$A_SSH_PHP_MOUNT = "$($A_SSH_HOME):/home/php-user/.ssh"

# Mount for cache
$A_NPM_CONFIG_MOUNT = "$($A_NPM_CONFIG):/home/node-user/.npm-packages"
$A_NPM_CACHE_MOUNT = "$($A_NPM_CACHE):/home/node-user/.npm"
$A_COMPOSER_MOUNT = "$($A_COMPOSER_CACHE):/home/php-user/.composer"
$A_YARN_BIN_MOUNT = "$($A_YARN_BIN):/home/node-user/.local/bin"
$A_YARN_CONFIG_MOUNT = "$($A_YARN_CONFIG):/home/node-user/.yarn-config"
$A_YARN_CACHE_MOUNT = "$($A_YARN_CACHE):/home/node-user/.yarn-cache"

####
# Alias for NPM And other node commands
####

# Node Env
function nAlias() {
    docker run -it --rm -v "$(Get-Location):/var/www/app" -v $A_NPM_CACHE_MOUNT -v $A_YARN_BIN_MOUNT -v $A_YARN_CONFIG_MOUNT -v $A_YARN_CACHE_MOUNT -v $A_NPM_CONFIG_MOUNT -v $A_SSH_NODE_MOUNT ambientum/node:7 @args
}
Set-alias n nAlias

# PHP Env
function pAlias() {
    docker run -it --rm -v "$(Get-Location):/var/www/app" -v $A_COMPOSER_MOUNT -v $A_SSH_PHP_MOUNT ambientum/php:7.1 @args
}
Set-Alias p pAlias