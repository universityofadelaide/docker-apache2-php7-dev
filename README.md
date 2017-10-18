
Docker image with xdebug and other development tools.

Inherits from the production container ```uofa/docker_apache2_php7```

## To build manually:
```bash
docker build -t uofa/apache2-php7-dev .
```

or use the script:
```bash
./build.sh
```

## Using with openshift locally

For building with openshift, you probably want information from the
documentation https://github.com/openshift/origin/blob/master/docs/cluster_up_down.md#accessing-the-openshift-registry-directly
