FROM plugins/base:multiarch

LABEL org.label-schema.version=latest
LABEL org.label-schema.vcs-url="https://github.com/appleboy/gorush.git"
LABEL org.label-schema.name="Gorush"
LABEL org.label-schema.vendor="Bo-Yi Wu"
LABEL org.label-schema.schema-version="1.0"
LABEL maintainer="Bo-Yi Wu <appleboy.tw@gmail.com>"

ADD release/linux/amd64/gorush /bin/

# the file for config.core.cert_path
RUN if [ ! -z "$CORE__CERT_PATHFILE" ]; then echo $CORE__CERT_PATHFILE | base64 -d > cert.pem; fi
# the file for config.core.key_path
RUN if [ ! -z "$CORE__KEY_PATHFILE" ]; then echo $CORE__KEY_PATHFILE | base64 -d > key.pem; fi
# ios key file
RUN if [ ! -z "$IOS__KEY_FILE" ]; then echo $IOS__KEY_FILE | base64 -d > ios_key.pem; fi
RUN if [ ! -z "$CONFIG_YML" ]; then echo $CONFIG_YML | base64 -d > config.yml; fi

EXPOSE 8088 9000
ENTRYPOINT ["/bin/gorush"]
