# CentOS based image for development

This is the base service image for development with C# and C++ on a linux base. It will install .NET core, C++ (i.e. GCC, GDB), cmake, conan and some other required tools.

```bash
docker build -t microservice-development-centos -f Dockerfile .
docker tag service-centos microservice-development-centos:latest
docker push microservice-development-centos:latest

docker run --rm --name pf-service -it service-centos:latest
```

## Using image directly from docker repository

Fetching the image from repo and running it interactively:

```bash
docker pull microservice-development-centos:latest
docker run --rm --memory="2g" --memory-swap="2g" --name develop -it microservice-development-centos:latest bash
```

