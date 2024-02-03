FROM amd64/rust:slim-bullseye
ARG USER_ID
ARG VERSION

RUN if getent passwd $USER_ID >/dev/null; then \
        existing_user=$(getent passwd $USER_ID | cut -d: -f1) && \
        usermod -l debian $existing_user; \
    else \
        useradd -u $USER_ID -m debian; \
    fi

RUN mkdir /lwk-dart
RUN chown -R debian /lwk-dart

RUN apt-get update --allow-releaseinfo-change && \
    apt-get install -y build-essential \
    cmake apt-transport-https ca-certificates curl \
    wget gnupg2 software-properties-common dirmngr unzip \
    openssl libssl-dev git expect jq lsb-release tree \
    pkg-config autoconf libtool neovim


RUN mkdir /.cargo
RUN chown -R debian /.cargo
RUN cargo 
COPY Cargo.toml /.cargo/config
ENV CARGO_HOME=/.cargo
ENV NDK_VERSION=23.0.7599858

VOLUME ["/lwk-dart"]

# WORKDIR /lwk-dart

#Used for cargo build to find Cargo.toml 

RUN rustup target add x86_64-unknown-linux-gnu
#RUN TARGET_CC=x86_64-unknown-linux-gnu cargo build --target-dir ./lwk-dart -r --target=x86_64-unknown-linux-gnu


COPY docker-entrypoint.sh /usr/bin
USER debian

ENTRYPOINT ["docker-entrypoint.sh"]

# docker build --platform linux/x86_64 --build-arg USER_ID=$(id -u) -t bwcbuilder . 
# in the project root directory run:
# docker run --platform linux/x86_64 --name bwcbuilder01 -v $PWD:/lwk-dart bwcbuilder && docker stop bwcbuilder01 && docker rm bwcbuilder01