[![Build status](https://github.com/xip-online-applications/php-docker-containers/actions/workflows/main.yaml/badge.svg)](https://github.com/xip-online-applications/php-docker-containers/actions/workflows/main.yaml)

# Reusable PHP Docker containers
It is a lot of work to build PHP containers over and over again, let alone the wait for containers to build. This project makes that life easier by providing fully reusable PHP base containers and extensions.

The main idea behind this project is based on the [Bref](https://github.com/brefphp/bref) development containers. This project provides a base [PHP or PHP-FPM container](https://github.com/xip-online-applications/php-docker-containers/pkgs/container/php-docker-containers%2Fphp) and many prebuild extensions. All you have to do, is combine them into your own project.

## How to use
Using this project is fairly easy. You start your Dockerfile with the base container. The base containers life in registry `ghcr.io/xip-online-applications/php-docker-containers/php` and are versions like this: `<PHP VERSION>[.<CONTAINER RELEASE VERSION>][-fpm]`. Example for PHP-FPM version 8:

```Dockerfile
FROM ghcr.io/xip-online-applications/php-docker-containers/php:8.1-fpm
```

Now lets say you want to use the extensions MySQL and Redis. Each extension lifes in its ow registry like `ghcr.io/xip-online-applications/php-docker-containers/php-extra-mysql` for MySQL. The versionsing is the same as with the base image; `<PHP VERSION>[.<CONTAINER RELEASE VERSION>]`. All you have to do is copy the `/opt` dir from the extension image to the `/opt` directory in your image. You can add them to your Dockerfile like this:

```Dockerfile
COPY --from=ghcr.io/xip-online-applications/php-docker-containers/php-extra-mysql:8.1 /opt /opt
COPY --from=ghcr.io/xip-online-applications/php-docker-containers/php-extra-redis:8.1 /opt /opt
```

Now if you want to use some development tools like xDebug and use development settings, you can use the `ghcr.io/xip-online-applications/php-docker-containers/php-extra-dev` image:

```Dockerfile
COPY --from=ghcr.io/xip-online-applications/php-docker-containers/php-extra-dev:8.1 /opt /opt
```

To undo these dev settings, you can use the `ghcr.io/xip-online-applications/php-docker-containers/php-extra-prod` AFTER the dev extension.

Check the [example](./example) directory for a fully working example of the above within a multi-stage build.

## Available extensions
See the list of available extensions below:

| Extension | Container                                                                | Notes                                                |
|-----------|--------------------------------------------------------------------------|------------------------------------------------------|
| amqp      | ghcr.io/xip-online-applications/php-docker-containers/php-extra-amqp     |                                                      |
| bcmath    | ghcr.io/xip-online-applications/php-docker-containers/php-extra-bcmath   |                                                      |
| composer  | ghcr.io/xip-online-applications/php-docker-containers/php-extra-composer |                                                      |
| curl      | ghcr.io/xip-online-applications/php-docker-containers/php-extra-curl     |                                                      |
| datadog   | ghcr.io/xip-online-applications/php-docker-containers/php-extra-datadog  |                                                      |
| gd        | ghcr.io/xip-online-applications/php-docker-containers/php-extra-gd       |                                                      |
| intl      | ghcr.io/xip-online-applications/php-docker-containers/php-extra-intl     |                                                      |
| mbstring  | ghcr.io/xip-online-applications/php-docker-containers/php-extra-mbstring |                                                      |
| mongodb   | ghcr.io/xip-online-applications/php-docker-containers/php-extra-mongodb  |                                                      |
| mysql     | ghcr.io/xip-online-applications/php-docker-containers/php-extra-mysql    |                                                      |
| nodejs    | ghcr.io/xip-online-applications/php-docker-containers/php-extra-nodejs   | Versioning based on node versions: 14, 16, 18 and 19 |
| opcache   | ghcr.io/xip-online-applications/php-docker-containers/php-extra-opcache  |                                                      |
| pcntl     | ghcr.io/xip-online-applications/php-docker-containers/php-extra-pcntl    |                                                      |
| redis     | ghcr.io/xip-online-applications/php-docker-containers/php-extra-redis    |                                                      |
| saxonc    | ghcr.io/xip-online-applications/php-docker-containers/php-extra-saxonc   | Only for PHP version 7.4                             |
| xdebug    | ghcr.io/xip-online-applications/php-docker-containers/php-extra-xdebug   |                                                      |
| xml       | ghcr.io/xip-online-applications/php-docker-containers/php-extra-xml      |                                                      |
| xsl       | ghcr.io/xip-online-applications/php-docker-containers/php-extra-xsl      |                                                      |
| zip       | ghcr.io/xip-online-applications/php-docker-containers/php-extra-zip      |                                                      |

There are also some environment specific extensions available:

| Extension | Container                                                            | Notes                                                 |
|-----------|----------------------------------------------------------------------|-------------------------------------------------------|
| dev       | ghcr.io/xip-online-applications/php-docker-containers/php-extra-dev  | Will set some development PHP settings and add xDebug |
| prod      | ghcr.io/xip-online-applications/php-docker-containers/php-extra-prod | Will undo dev extension settings                      |

## Development
To develop a new extension, you need to make sure you do the following:

* Add the extension to the [`src/extensions](./src/extensions/) directory (like the others)
* Make sure your extension image is based on `scratch` with a copyable `/opt` directory
* The build of your extension is added to [`.github/workflows/build-extensions.yaml`](./.github/workflows/build-extensions.yaml)
