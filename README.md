# Symfony Docker *template*

## Prerequisites

Install Docker

Install docker-compose

Install make (install by default on Linux and MacOS)

### Documentation

Install Docker for Windows : https://hub.docker.com/editions/community/docker-ce-desktop-windows

Install Docker for Mac : https://store.docker.com/editions/community/docker-ce-desktop-mac

Install Docker for Linux (Ubuntu) : https://medium.com/@techgeek628/installing-docker-and-docker-compose-on-ubuntu-18-04-16-04-a38179502d9b

## Install

Clone the template : 

```bash
# Symfony 5.2 template
git clone https://github.com/QuentG/symfony-docker-template
```

Copy .env :

```bash
cp .env.dist .env
rm .env.dist
```

### Set variables

Replace ***[ProjectName]*** by your project name in :

- [docker-compose.yml](https://github.com/QuentG/symfony-docker-template/blob/master/docker-compose.yml)
- [vhost.conf](https://github.com/QuentG/symfony-docker-template/blob/master/docker/vhost.conf)

Replace MYSQL environment variables in docker-compose.yml and .env :

```bash
# docker-compose.yml
MYSQL_DATABASE=sandboxdb
MYSQL_USER=sandboxuser
MYSQL_PASSWORD=sandboxpassword

# .env
DATABASE_URL="mysql://sandboxuser:sandboxpassword@mysql:3306/sandboxdb?serverVersion=5.7"
```

### Build

Follow steps to build docker containers and install project by using MakeFile :

```bash
# Build docker
make build

# Start docker containers
make dev

# Install project
make install

# Install fresh database and populate it 
make seed
```

## Try local

http://localhost:8080

## Customization

#### Define custom localhost url : 

Add extra_hosts on php service in [docker-compose.yml](https://github.com/QuentG/symfony-docker-template/blob/master/docker-compose.yml) :

```bash
php:
    build: .
    image: php-apache
    ...
    extra_hosts:
      - "custom-local.myproject.com:127.0.0.1"
    ports:
      - "8080:80"
```

Add in your hosts file :

```
127.0.0.1 custom-local.myproject.com
```

Made new docker build and try with custom url :

http://custom-local.myproject.com

Enjoy 🔥 

## More

Mysql container available here : 

```bash
# Connect to container
docker-compose exec mysql bash
# or
make mysql
```