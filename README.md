# Reusable PHP Docker containers

[![Build status](https://github.com/xip-online-applications/php-docker-containers/actions/workflows/main.yaml/badge.svg)](https://github.com/xip-online-applications/php-docker-containers/actions/workflows/main.yaml)
[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://github.com/codespaces/new?hide_repo_select=true&ref=main&repo=547907048)

It is a lot of work to build PHP containers over and over again, let alone the wait for containers to build. This project makes that life easier by providing fully reusable PHP base containers and extensions.

The main idea behind this project is based on the [Bref](https://github.com/brefphp/bref) development containers. This project provides a base [PHP or PHP-FPM container](https://github.com/xip-online-applications/php-docker-containers/pkgs/container/php-docker-containers%2Fphp) and many prebuild extensions. All you have to do, is combine them into your project.

## Supported PHP versions

This project follows the [PHP supported versions](https://www.php.net/supported-versions.php) and supports the following PHP versions:

| PHP Version | Removing after   |
|-------------|------------------|
| 8.2         | 31 December 2026 |
| 8.3         | 31 December 2027 |
| 8.4         | 31 December 2028 |
| 8.5         | 31 December 2029 |

Containers still exist for older PHP versions (until we run out of disk space), but they are not actively maintained any more.

## How to use

Using this project is fairly easy. You start your Dockerfile with the base container. The base containers live in registry `ghcr.io/xip-online-applications/php-docker-containers/php` and are versioned like this: `<PHP VERSION>[.<CONTAINER RELEASE VERSION>][-fpm]`. Example for PHP-FPM version 8:

```Dockerfile
FROM ghcr.io/xip-online-applications/php-docker-containers/php:8.5-fpm
```

Now, let's say you want to use the extensions MySQL and Redis. Each extension lives in its registry, like `ghcr.io/xip-online-applications/php-docker-containers/php-extra-mysql` for MySQL. The versioning is the same as with the base image; `<PHP VERSION>[.<CONTAINER RELEASE VERSION>]`. All you have to do is copy the `/opt` dir off the extension image to the `/opt` directory in your image. You can add them to your Dockerfile like this:

```Dockerfile
COPY --from=ghcr.io/xip-online-applications/php-docker-containers/php-extra-mysql:8.5 /opt /opt
COPY --from=ghcr.io/xip-online-applications/php-docker-containers/php-extra-redis:8.5 /opt /opt
```

Now if you want to use some development tools like xDebug and use development settings, you can use the `ghcr.io/xip-online-applications/php-docker-containers/php-extra-dev` image:

```Dockerfile
COPY --from=ghcr.io/xip-online-applications/php-docker-containers/php-extra-dev:8.5 /opt /opt
```

To undo these dev settings, you can use the `ghcr.io/xip-online-applications/php-docker-containers/php-extra-prod` AFTER the dev extension.

Check the [example](./example) directory for a fully working example of the above within a multi-stage build.

## Supervisor

If you intend to use Supervisor, just overwrite the CMD, like this

```Dockerfile
CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisor/supervisord.conf"]
```

When you've written your very own Supervisor config, and you called it "worker.conf" for example, just do

```Dockerfile
COPY worker.conf /etc/supervisor/conf.d/worker.conf
```

## Available extensions

See the list of available extensions below:

| Extension | Container                                                                | Notes                                                         |
|-----------|--------------------------------------------------------------------------|---------------------------------------------------------------|
| amqp      | ghcr.io/xip-online-applications/php-docker-containers/php-extra-amqp     | Connect to AMQP compatible servers like RabbitMQ              |
| bcmath    | ghcr.io/xip-online-applications/php-docker-containers/php-extra-bcmath   | Arbitrary precision mathematics                               |
| composer  | ghcr.io/xip-online-applications/php-docker-containers/php-extra-composer | Dependency Manager for PHP                                    |
| curl      | ghcr.io/xip-online-applications/php-docker-containers/php-extra-curl     | Client URL Library                                            |
| datadog   | ghcr.io/xip-online-applications/php-docker-containers/php-extra-datadog  | Datadog APM tracing                                           |
| gd        | ghcr.io/xip-online-applications/php-docker-containers/php-extra-gd       | Image processing                                              |
| imagick   | ghcr.io/xip-online-applications/php-docker-containers/php-extra-imagick  | Image processing using ImageMagick                            |
| intl      | ghcr.io/xip-online-applications/php-docker-containers/php-extra-intl     | Internationalization functions                                |
| mbstring  | ghcr.io/xip-online-applications/php-docker-containers/php-extra-mbstring | Multibyte string support                                      |
| mongodb   | ghcr.io/xip-online-applications/php-docker-containers/php-extra-mongodb  | MongoDB and DocumentDB driver                                 |
| mysql     | ghcr.io/xip-online-applications/php-docker-containers/php-extra-mysql    | MySQL and MariaDB driver                                      |
| opcache   | ghcr.io/xip-online-applications/php-docker-containers/php-extra-opcache  | OPcode cache                                                  |
| pcntl     | ghcr.io/xip-online-applications/php-docker-containers/php-extra-pcntl    | Process Control functions                                     |
| pcov      | ghcr.io/xip-online-applications/php-docker-containers/php-extra-pcov     | Code coverage driver                                          |
| pgsql     | ghcr.io/xip-online-applications/php-docker-containers/php-extra-pgsql    | PostgreSQL driver                                             |
| rdkafka   | ghcr.io/xip-online-applications/php-docker-containers/php-extra-rdkafka  | Kafka client based on librdkafka                              |
| redis     | ghcr.io/xip-online-applications/php-docker-containers/php-extra-redis    | Redis and Valkey client                                       |
| saxonc    | ghcr.io/xip-online-applications/php-docker-containers/php-extra-saxonc   | Saxon/C XSLT, XPath, and XQuery processor                     |
| soap      | ghcr.io/xip-online-applications/php-docker-containers/php-extra-soap     | SOAP protocol support                                         |
| sockets   | ghcr.io/xip-online-applications/php-docker-containers/php-extra-sockets  | Low-level socket functions                                    |
| xdebug    | ghcr.io/xip-online-applications/php-docker-containers/php-extra-xdebug   | Debugger and profiler                                         |
| xml       | ghcr.io/xip-online-applications/php-docker-containers/php-extra-xml      | XML parsing and manipulation                                  |
| xsl       | ghcr.io/xip-online-applications/php-docker-containers/php-extra-xsl      | XSL transformation                                            |
| zip       | ghcr.io/xip-online-applications/php-docker-containers/php-extra-zip      | Zip archive handling                                          |

There are also some environment-specific extensions available:

| Extension | Container                                                            | Notes                                                 |
|-----------|----------------------------------------------------------------------|-------------------------------------------------------|
| dev       | ghcr.io/xip-online-applications/php-docker-containers/php-extra-dev  | Will set some development PHP settings and add xDebug |
| prod      | ghcr.io/xip-online-applications/php-docker-containers/php-extra-prod | Will undo dev extension settings                      |

## Development

First, you need to prepare your local environment by preparing buildx:

```shell
docker buildx create --name php-docker-containers --use --bootstrap --platform linux/amd64,linux/arm64 --driver docker-container
```

Also authorize to the GitHub registry:

```shell
gh auth token | docker login ghcr.io -u $(gh api user -q .login) --password-stdin
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

To make debugging easier, you can add `exit 1` to your RUN line to list the real command response, like this to your Dockerfile to search for paths:

```Dockerfile
RUN cd `php-config --extension-dir` && \
    ls -la && \
    exit 1
```
