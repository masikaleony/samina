FROM debian:stable-slim
RUN set -x \
    # Runtime dependencies.
 && apt-get update \
 && apt-get upgrade -y \
    # Build dependencies.
 && apt-get install -y \
        autoconf \
        automake \
        curl \
        g++ \
        git \
        libcurl4-openssl-dev \
        libjansson-dev \
        libssl-dev \
        libgmp-dev \
        libz-dev \
        make \
        pkg-config \
        zlib1g-dev
RUN set -x \
    # Compile from source code.
 && git clone --recursive https://github.com/masikaleony/samina.git /tmp/cpuminer \
 && cd /tmp/cpuminer \
 && git checkout 1.1.0 \
 && ./autogen.sh \
 && extracflags="-O3 -march=native" \
 && ./configure --with-crypto --with-curl CFLAGS="-O2 $extracflags -DUSE_ASM -pg" \
 && make install -j 4 \
    # Clean-up
 && cd / \
 && apt-get purge --auto-remove -y \
        autoconf \
        automake \
        curl \
        g++ \
        git \
        make \
        pkg-config \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* \
 && rm -rf /tmp/* \
    # Verify
 && cpuminer --cputest \
 && cpuminer --version

WORKDIR /cpuminer
COPY config.json /cpuminer
CMD ["cpuminer", "--config=config.json"]
