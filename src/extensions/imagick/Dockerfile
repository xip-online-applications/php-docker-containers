ARG REPO
ARG PHP_VERSION
FROM ${REPO}:${PHP_VERSION} AS ext

RUN apt-get update \
	&& apt-get install -y libmagickwand-dev ghostscript fontconfig fonts-noto-color-emoji \
	&& apt-get clean

RUN MAKE="make -j$(nproc)" \
	pecl install --configureoptions 'with-imagick="autodetect"' imagick \
	&& docker-php-ext-enable imagick

RUN mkdir -p /tmp/extensions /tmp/conf.d /tmp/bin /tmp/share/ghostscript /tmp/share/fonts /tmp/lib /tmp/etc/fonts
RUN cp `php-config --extension-dir`/imagick.so /tmp/extensions/imagick.so
RUN echo "extension=/opt/php/extensions/imagick.so" | tee /tmp/conf.d/ext-imagick.ini
RUN cp /usr/bin/gs /tmp/bin/gs.real
RUN GS_VERSION="$(gs --version)" \
	&& cat > /tmp/bin/gs <<EOF
#!/bin/sh
export GS_LIB="/opt/share/ghostscript/${GS_VERSION}/lib:/opt/share/ghostscript/${GS_VERSION}/Resource/Init:/opt/share/ghostscript/${GS_VERSION}/Resource/Font:/opt/share/ghostscript/${GS_VERSION}/iccprofiles:/opt/share/fonts"
exec /opt/bin/gs.real "\$@"
EOF
RUN chmod +x /tmp/bin/gs
RUN cp -a /usr/share/ghostscript/. /tmp/share/ghostscript/ \
	&& find /tmp/share/ghostscript -name iccprofiles -type l -exec sh -c \
		'target=$(realpath /usr/share/ghostscript/*/iccprofiles) && rm "$1" && cp -a "$target" "$1"' _ {} \;
RUN cp -a /usr/share/fonts/. /tmp/share/fonts/
RUN if [ -f /etc/fonts/fonts.conf ]; then cp /etc/fonts/fonts.conf /tmp/etc/fonts/fonts.conf; fi
RUN for dir in /etc/ImageMagick-*; do \
		[ -d "$dir" ] && cp -a "$dir" /tmp/share/; \
	done

RUN mkdir -p /tmp/lib64 \
	&& { \
			ldd /tmp/extensions/imagick.so; \
			ldd /tmp/bin/gs.real; \
			find /usr/lib -name "libMagick*.so*" -exec ldd {} +; \
			find /usr/lib -name "libgs.so*" -exec ldd {} +; \
		} 2>/dev/null \
		| grep '=> /' | awk '{print $3}' | sort -u \
		| while read lib; do cp -dL "$lib" /tmp/lib64/ 2>/dev/null || true; done
RUN for dir in /usr/lib/*/ImageMagick-*; do \
		[ -d "$dir" ] && cp -a "$dir" /tmp/lib/; \
	done
RUN cd /tmp/lib && ln -sf ImageMagick-*/modules-*/coders im-coders

FROM scratch
COPY --from=ext /tmp/extensions/ /opt/php/extensions/
COPY --from=ext /tmp/conf.d /opt/php/conf.d/
COPY --from=ext /tmp/bin/ /opt/bin/
COPY --from=ext /tmp/lib64 /opt/php/lib64/
COPY --from=ext /tmp/lib/ /opt/lib/
COPY --from=ext /tmp/share/ /opt/share/
COPY --from=ext /tmp/etc/fonts/fonts.conf /etc/fonts/fonts.conf
