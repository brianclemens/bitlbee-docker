FROM alpine:latest

ARG BUILD_DATE
ARG MAKEFLAGS=-j12
ARG VCS_REF

LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="BitlBee" \
      org.label-schema.description="BitlBee, fully loaded." \
      org.label-schema.url="https://tiuxo.com" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/brianclemens/bitlbee" \
      org.label-schema.vendor="Tiuxo" \
      org.label-schema.schema-version="1.0"

ENV BITLBEE_COMMIT 246b98b
ENV DISCORD_COMMIT 4fc5649
ENV FACEBOOK_COMMIT 553593d
ENV HANGOUTS_COMMIT 0e137e6
ENV LINE_COMMIT 156f411
ENV MASTODON_COMMIT 0095ef0
ENV MATRIX_COMMIT 49ea988
ENV MATTERMOST_COMMIT bc02343
ENV PUSHBULLET_COMMIT d0898fd
ENV ROCKETCHAT_COMMIT fb8dcc6
ENV SKYPE_COMMIT c395028
ENV SLACK_COMMIT b0f1550
ENV STEAM_COMMIT a6444d2
ENV TELEGRAM_COMMIT 94dd3be
ENV VK_COMMIT 51a91c8
ENV WECHAT_COMMIT 17b15e5
ENV WHATSAPP_COMMIT 81c7285
ENV YAHOO_COMMIT fbbd9c5

RUN apk update \
    && apk upgrade \
    && apk add --virtual build-dependencies \
    autoconf \
    automake \
    bison \
    boost-dev \
    build-base \
    cargo \
    clang \
    cmake \
    curl \
    discount-dev \
    flex \
    git \
    http-parser-dev \
    json-glib-dev \
    libotr-dev \
    libtool \
    libxml2-dev \
    mercurial \
    openssl-dev \
    protobuf-c-dev \
    protobuf-dev \
    && apk add --virtual runtime-dependencies \
    glib-dev \
    gnutls-dev \
    json-glib \
    libgcrypt-dev \
    libotr \
    libpurple \
    libpurple-bonjour \
    libpurple-oscar \
    libpurple-xmpp \
    libwebp-dev \
    openssl \
    pidgin-dev \
    protobuf-c

# bitlbee
RUN cd /root \
    && git clone -n https://github.com/bitlbee/bitlbee \
    && cd bitlbee \
    && git checkout ${BITLBEE_COMMIT} \
    && mkdir /bitlbee-data \
    && ./configure --build=x86_64-alpine-linux-musl --host=x86_64-alpine-linux-musl --otr=plugin --purple=1 --ssl=openssl --config=/bitlbee-data \
    && make \
    && make install \
    && make install-dev \
    && make install-etc \
    && rm -rf /root/ /root/.*

# discord
RUN cd /root \
    && git clone -n https://github.com/sm00th/bitlbee-discord \
    && cd bitlbee-discord \
    && git checkout ${DISCORD_COMMIT} \
    && ./autogen.sh \
    && ./configure \
    && make \
    && make install \
    && strip /usr/local/lib/bitlbee/discord.so \
    && rm -rf /root/ /root/.*

# facebook
RUN cd /root \
    && git clone -n https://github.com/jgeboski/bitlbee-facebook \
    && cd bitlbee-facebook \
    && git checkout ${FACEBOOK_COMMIT} \
    && ./autogen.sh \
    && make \
    && make install \
    && strip /usr/local/lib/bitlbee/facebook.so \
    && rm -rf /root/ /root/.*

# hangouts
RUN cd /root \
    && hg clone -U https://bitbucket.org/EionRobb/purple-hangouts \
    && cd purple-hangouts \
    && hg update ${HANGOUTS_COMMIT} \
    && make \
    && make install \
    && strip /usr/lib/purple-2/libhangouts.so \
    && rm -rf /root/ /root/.*

# naver line
RUN cd /root \
    && git clone -n https://gitlab.com/bclemens/purple-line \
    && cd purple-line \
    && git checkout ${LINE_COMMIT} \
    && make THRIFT_STATIC=true \
    && make install \
    && strip /usr/lib/purple-2/libline.so \
    && rm -rf /root/ /root/.*

# mastodon
RUN cd /root \
    && git clone -n https://github.com/kensanata/bitlbee-mastodon \
    && cd bitlbee-mastodon \
    && git checkout ${MASTODON_COMMIT} \
    && ./autogen.sh \
    && ./configure \
    && make \
    && make install \
    && strip /usr/local/lib/bitlbee/mastodon.so \
    && rm -rf /root/* /root/.*

# matrix
RUN cd /root \
    && git clone -n https://github.com/matrix-org/purple-matrix \
    && cd purple-matrix \
    && git checkout ${MATRIX_COMMIT} \
    && make \
    && make install \
    && strip /usr/lib/purple-2/libmatrix.so \
    && rm -rf /root/* /root/.*

# mattermost
RUN cd /root \
    && git clone -n https://github.com/EionRobb/purple-mattermost \
    && cd purple-mattermost \
    && git checkout ${MATTERMOST_COMMIT} \
    && make \
    && make install \
    && strip /usr/lib/purple-2/libmattermost.so \
    && rm -rf /root/* /root/.*

# pushbullet
RUN cd /root \
    && git clone -n https://github.com/EionRobb/pidgin-pushbullet \
    && cd pidgin-pushbullet \
    && git checkout ${PUSHBULLET_COMMIT} \
    && make \
    && make install \
    && strip /usr/lib/purple-2/libpushbullet.so \
    && rm -rf /root/* /root/.*

# skype
RUN cd /root \
    && git clone -n https://github.com/EionRobb/skype4pidgin \
    && cd skype4pidgin \
    && git checkout ${SKYPE_COMMIT} \
    && cd skypeweb \
    && make \
    && make install \
    && strip /usr/lib/purple-2/libskypeweb.so \
    && rm -rf /root/* /root/.*

# rocket.chat
RUN cd /root \
    && hg clone -U https://bitbucket.org/EionRobb/purple-rocketchat \
    && cd purple-rocketchat \
    && hg update ${ROCKETCHAT_COMMIT} \
    && make \
    && make install \
    && strip /usr/lib/purple-2/librocketchat.so \
    && rm -rf /root/* /root/.*

# slack
RUN cd /root \
    && git clone -n https://github.com/dylex/slack-libpurple \
    && cd slack-libpurple \
    && git checkout ${SLACK_COMMIT} \
    && make \
    && make install \
    && rm -rf /root/* /root/.*

# steam
RUN cd /root \
    && git clone -n https://github.com/bitlbee/bitlbee-steam \
    && cd bitlbee-steam \
    && git checkout ${STEAM_COMMIT} \
    && ./autogen.sh \
    && make \
    && make install \
    && strip /usr/local/lib/bitlbee/steam.so \
    && rm -rf /root/* /root/.*

# telegram
RUN cd /root \
    && git clone -n https://github.com/majn/telegram-purple \
    && cd telegram-purple \
    && git checkout ${TELEGRAM_COMMIT} \
    && git submodule update --init --recursive \
    && ./configure \
    && make \
    && make install \
    && strip /usr/lib/purple-2/telegram-purple.so \
    && rm -rf /root/* /root/.*

# wechat
RUN cd /root \
    && git clone -n https://github.com/sbwtw/pidgin-wechat \
    && cd pidgin-wechat \
    && git checkout ${WECHAT_COMMIT} \
    && cargo build --release \
    && cp target/release/libwechat.so /usr/lib/purple-2/ \
    && strip /usr/lib/purple-2/libwechat.so \
    && rm -rf /root/* /root/.*

# vkontakt
RUN cd /root \
    && hg clone -U https://bitbucket.org/olegoandreev/purple-vk-plugin \
    && cd purple-vk-plugin \
    && hg update ${VK_COMMIT} \
    && cd build \
    && cmake .. \
    && make \
    && make install \
    && strip /usr/lib/purple-2/libpurple-vk-plugin.so \
    && rm -rf /root/* /root/.*

# whatsapp
RUN cd /root \
    && git clone -n https://github.com/jakibaki/whatsapp-purple \
    && cd whatsapp-purple \
    && git checkout ${WHATSAPP_COMMIT} \
    && make \
    && make install \
    && strip /usr/lib/purple-2/libwhatsapp.so \
    && rm -rf /root/* /root/.*

# yahoo
RUN cd /root \
    && git clone -n https://github.com/EionRobb/funyahoo-plusplus \
    && cd funyahoo-plusplus \
    && git checkout ${YAHOO_COMMIT} \
    && make \
    && make install \
    && strip /usr/lib/purple-2/libyahoo-plusplus.so \
    && rm -rf /root/* /root/.*

# clean up, create user, set permissions
RUN apk del --purge build-dependencies \
    && rm -rf /root/ /root/.* \
    && rm -rf /var/cache/apk/* \
    && adduser -u 1000 -S bitlbee \
    && addgroup -g 1000 -S bitlbee \
    && chown -R bitlbee:bitlbee /bitlbee-data \
    && touch /var/run/bitlbee.pid \
    && chown bitlbee:bitlbee /var/run/bitlbee.pid; exit 0

USER bitlbee
VOLUME /bitlbee-data
ENTRYPOINT ["/usr/local/sbin/bitlbee", "-F", "-n", "-d", "/bitlbee-data"]
