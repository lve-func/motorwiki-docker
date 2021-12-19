FROM mediawiki:1.37
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y  ffmpeg \
        ghostscript \
        xpdf-utils \
        libldap2-dev \
        libldb-dev \
        jq && \
    ln -s /usr/lib/x86_64-linux-gnu/libldap.so /usr/lib/libldap.so && \
    ln -s /usr/lib/x86_64-linux-gnu/liblber.so /usr/lib/liblber.so && \
    docker-php-ext-install ldap

WORKDIR /var/www/html/extensions
COPY get-extensions.sh .
RUN bash get-extensions.sh LDAPAuthorization \
    LDAPAuthentication2 \
    LDAPGroups \
    LDAPProvider \
    LDAPUserInfo \
    PluggableAuth
