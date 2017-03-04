#####
# Ambientum 1.0
# Uses the default/official MySQl 8.0 image with some little tricks
# on the configuration to work with Laravel/Lumen
#####
FROM mysql:8.0

# Repository/Image Maintainer
MAINTAINER Diego Hernandes <diego@hernandev.com>

# Laravel requirement for preventing migration timestamp incompatibility
COPY mode.cnf /etc/mysql/mysql.conf.d/mode.cnf
