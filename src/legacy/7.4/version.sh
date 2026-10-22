#!/bin/sh
# Prints VERSION=<PHP version>-<short php-src commit> (e.g. 7.4.34-dev-712e60f) from the Dockerfile,
# for the image tags in .github/workflows/php-7.4.yaml.
set -eu
dockerfile="$(dirname "$0")/Dockerfile"
php_version="$(sed -n 's/^ENV PHP_VERSION \(.*\)$/\1/p' "$dockerfile")"
php_commit="$(sed -n 's/^ENV PHP_SRC_COMMIT="\([0-9a-f]*\)"$/\1/p' "$dockerfile")"
[ -n "$php_version" ] && [ -n "$php_commit" ]
echo "VERSION=$php_version-$(echo "$php_commit" | cut -c1-7)"
