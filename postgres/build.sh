#!/usr/bin/env bash

# Set the resulting images namespace (docker hub organization or other)
NAMESPACE=ambientum

# Set the publishing or not of built images
PUBLISH_IMAGES=$1

# Base Funtion that builds the repositories
function build_version {
  # Current repository name to build
  IMAGE=$NAMESPACE/postgres:$2

  # Greatings
  echo "--> Building "$IMAGE"..."

  # Enter repository directory
  cd $1

  # Build the image
  docker build -t $IMAGE .

    # If publishing is enabled
    if [ ! -z "$PUBLISH_IMAGES" ]; then
      # Push the built image
      docker push $IMAGE
    fi

    # Return to the main directory
    cd ..
}

# Initial greatings
echo "--> Building PostgreSQL Images..."

# 9.3
build_version 9.3 9.3

# 9.4
build_version 9.4 9.4

# 9.5
build_version 9.5 9.5

# 9.6
build_version 9.6 9.6

# latest (from 9.6)
build_version 9.6 latest
