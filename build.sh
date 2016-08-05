#!/usr/bin/env bash

# Detect base path
AMBIENTUM_ROOT=$(pwd)

# Set the resulting images namespace (docker hub organization or other)
AMBIENTUM_NAMESPACE=ambientum

# Set the publishing or not of built images
PUBLISH_IMAGES=$1

# Base Funtion that builds the repositories
function build_repository {
    # Current repository name to build
    REPOSITORY_NAME=$1

    # Enter repository directory
    cd $AMBIENTUM_ROOT/$REPOSITORY_NAME

    # Checkout on master
    git checkout master

    # Pull latest versions from git
    git pull --all

    # Build the images
    bash build.sh

    # If publishing is enabled
    if [ ! -z "$PUBLISH_IMAGES" ]; then
        # Return to master
        git checkout master

        # Publish the images
        bash publish.sh
    fi

    # Return to the root directory
    cd $AMBIENTUM_ROOT
}

# Initial greatings
echo "Ambientum auto build, starting..."

# Build MySQl
#build_repository mysql

# Build PostgreSQL
#build_repository postgres

# Build Redis
#build_repository redis

# Build PHP Base images
build_repository php
