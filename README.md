# Reusable PHP Docker containers

[![Build status](https://github.com/xip-online-applications/php-docker-containers/actions/workflows/main.yaml/badge.svg)](https://github.com/xip-online-applications/php-docker-containers/actions/workflows/main.yaml)
[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://github.com/codespaces/new?hide_repo_select=true&ref=main&repo=547907048)

It is a lot of work to build PHP containers over and over again, let alone the wait for containers to build. This project makes that life easier by providing fully reusable PHP base containers and extensions.

The main idea behind this project is based on the [Bref](https://github.com/brefphp/bref) development containers. This project provides a base [PHP or PHP-FPM container](https://github.com/xip-online-applications/php-docker-containers/pkgs/container/php-docker-containers%2Fphp) and many prebuild extensions. All you have to do, is combine them into your own project.

## Supported PHP versions

This project follows the [PHP supported versions](https://www.php.net/supported-versions.php) and supports the following PHP versions:

| PHP Version | Supported until  | Security fixes until |
|-------------|------------------|----------------------|
| 8.1         | 25 November 2024 | 31 December 2025     |
| 8.2         | 4 December 2025  | 31 December 2026     |
| 8.3         | 4 December 2026  | 31 December 2027     |
| 8.4         | 4 December 2027  | 31 December 2028     |

Containers still exist for PHP 7.4 and 8.0, but they are not actively maintained anymore.

## How to use

Using this project is fairly easy. You start your Dockerfile with the base container. The base containers live in registry `ghcr.io/xip-online-applications/php-docker-containers/php` and are versioned like this: `<PHP VERSION>[.<CONTAINER RELEASE VERSION>][-fpm]`. Example for PHP-FPM version 8:

```Dockerfile
FROM ghcr.io/xip-online-applications/php-docker-containers/php:8.1-fpm
```

Now lets say you want to use the extensions MySQL and Redis. Each extension lives in its ow registry like `ghcr.io/xip-online-applications/php-docker-containers/php-extra-mysql` for MySQL. The versioning is the same as with the base image; `<PHP VERSION>[.<CONTAINER RELEASE VERSION>]`. All you have to do is copy the `/opt` dir off the extension image to the `/opt` directory in your image. You can add them to your Dockerfile like this:

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
| nodejs    | ghcr.io/xip-online-applications/php-docker-containers/php-extra-nodejs   | Versioning based on node versions: 18, 20, and 22    |
| opcache   | ghcr.io/xip-online-applications/php-docker-containers/php-extra-opcache  |                                                      |
| pcov      | ghcr.io/xip-online-applications/php-docker-containers/php-extra-pcov     |                                                      |
| pcntl     | ghcr.io/xip-online-applications/php-docker-containers/php-extra-pcntl    |                                                      |
| rdkafka   | ghcr.io/xip-online-applications/php-docker-containers/php-extra-rdkafka  |                                                      |
| redis     | ghcr.io/xip-online-applications/php-docker-containers/php-extra-redis    |                                                      |
| saxonc    | ghcr.io/xip-online-applications/php-docker-containers/php-extra-saxonc   | Only for PHP version 7.4                             |
| soap      | ghcr.io/xip-online-applications/php-docker-containers/php-extra-soap     |                                                      |
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

First you need to prepare your local environment by preparing buildx:

```shell
docker buildx create --name php-docker-containers --use --bootstrap --driver docker-container
```

Also authorize to the Github registry with your Github PAT:

```shell
echo "$GITHUB_TOKEN" | docker login ghcr.io -u "$GITHUB_ACTOR" --password-stdin
```

To develop a new extension, you need to make sure you do the following:

* Add the extension to the [`src/extensions](./src/extensions/) directory (like the others)
* Make sure your extension image is based on `scratch` with a copyable `/opt` directory
* The build of your extension is added to [`.github/workflows/build-extensions.yaml`](./.github/workflows/build-extensions.yaml)
* Add the extension to the `README.md` file at section `Available extensions`

### Development build of an extension

To build an extension locally, you can use the following command:

```shell
make dev-extension-<EXTENSION>
```

This will build the extension with `DEV_BUILD_VERSION` defaulted to the lowest we support. You can override this by setting the `DEV_BUILD_VERSION` environment variable:

```shell
make dev-extension-<EXTENSION> DEV_BUILD_VERSION=8.3 
```

To make debugging easier, you can add `exit 1` to your RUN line to list the real command response like this to your Dockerfile to search for paths:

```Dockerfile
RUN cd `php-config --extension-dir` \
    && ls -la \
    && exit 1
```
