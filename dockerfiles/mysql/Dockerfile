FROM mysql:8.0.16

ARG DB_LANG=C
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update
RUN apt-get install -y locales
RUN echo "${DB_LANG}.UTF-8 UTF-8" > /etc/locale.gen && \
      locale-gen ${DB_LANG}.UTF-8 && \
      dpkg-reconfigure locales && \
      /usr/sbin/update-locale LANG=${DB_LANG}.UTF-8
ENV LC_ALL ${DB_LANG}.UTF-8
