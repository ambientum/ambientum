#!/usr/bin/env bash

set -e

# source env only when not on travis-ci.
if [[ -z $TRAVIS ]]; then
    # if there is a env file, source it
    if [ -f "./.env" ]; then
       source ./.env
    # source example else
    else
       source ./.env.example
    fi
fi


# enabled repositories for the build
REPOSITORIES=$1


# enable all repositories if any specified
if [[ -z $REPOSITORIES ]]; then
    REPOSITORIES="mkcert php beanstalkd node"
fi

# for returning later to the main directory
ROOT_DIRECTORY=`pwd`

# function for building images
function build_repository {
    # repository is the first argument.
    REPOSITORY=$1;
    # build mode is the second arg (--push|--load)
    MODE=${2:-"--load"};
    # target platform is the third arg (comma delimited).
    PLATFORM=${3:-linux/amd64,linux/arm64};

    # show building platforms.
    echo "Build mode: ${MODE}";
    echo "Building for platforms: ${PLATFORM}";

    # read repository configuration
    # shellcheck disable=SC1090
    source $ROOT_DIRECTORY/$REPOSITORY/buildvars

    # build all enabled versions
    for TAG in $TAGS; do
      # some verbose
      echo $'\n\n'"--> Building $NAMESPACE/$REPOSITORY:$TAG"$'\n'
      cd $ROOT_DIRECTORY/$REPOSITORY/$TAG

      if [ $USE_CACHE == true ]; then
        # build using cache
        docker buildx build --platform $PLATFORM $MODE -t $NAMESPACE/$REPOSITORY:$TAG .
      else
        docker buildx build --platform $PLATFORM $MODE --no-cache -t $NAMESPACE/$REPOSITORY:$TAG .
      fi
    done
}

# function for publishing images
function publish_repository {
    # read repository configuration
    source $ROOT_DIRECTORY/$REPOSITORY/buildvars

    # publish all enabled versions
    for TAG in $TAGS; do
      # some verbose
      echo $'\n\n'"--> Publishing $NAMESPACE/$REPOSITORY:$TAG"$'\n'
      # publish
      docker push $NAMESPACE/$REPOSITORY:$TAG
    done
}

# for each enabled repository
for REPOSITORY in $REPOSITORIES; do
  # If publishing is enabled
  if [ $PUBLISH == true ]; then
    # build the repository
    build_repository $REPOSITORY "--push" $DOCKER_PLATFORM
  else
    # build the repository
    build_repository $REPOSITORY "--load" $DOCKER_PLATFORM
  fi
done
