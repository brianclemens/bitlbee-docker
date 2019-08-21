## BitlBee, fully loaded.
[![Travis CI status badge](https://api.travis-ci.org/brianclemens/bitlbee-docker.svg?branch=master)](https://travis-ci.org/brianclemens/bitlbee-docker)
![Docker Pulls](https://img.shields.io/docker/pulls/bclemens/bitlbee.svg) ![Docker Stars](https://img.shields.io/docker/stars/bclemens/bitlbee.svg) [![Size](https://images.microbadger.com/badges/image/bclemens/bitlbee.svg)](https://microbadger.com/images/bclemens/bitlbee) [![](https://images.microbadger.com/badges/commit/bclemens/bitlbee.svg)](https://microbadger.com/images/bclemens/bitlbee)

BitlBee, with LDAP, OTR, Purple, and support for:
* AIM
* Bonjour
* [Discord](https://github.com/sm00th/bitlbee-discord)
* [Facebook](https://github.com/jgeboski/bitlbee-facebook)
* Gadu-Gadu
* [Hangouts](https://bitbucket.org/EionRobb/purple-hangouts)
* ICQ
* Indenti.ca
* Jabber / XMPP
* [Mastodon](https://github.com/kensanata/bitlbee-mastodon)
* [Matrix](https://github.com/matrix-org/purple-matrix)
* [Mattermost](https://github.com/EionRobb/purple-mattermost)
* [Naver LINE](https://gitlab.com/bclemens/purple-line)
* Novell GroupWise
* [Pushbullet](https://github.com/EionRobb/pidgin-pushbullet)
* [Rocket.Chat](https://bitbucket.org/EionRobb/purple-rocketchat)
* [Skype](https://github.com/EionRobb/skype4pidgin)
* [Slack](https://github.com/dylex/slack-libpurple)
* [Steam](https://github.com/bitlbee/bitlbee-steam)
* [Telegram](https://github.com/majn/telegram-purple)
* Twitter
* [Вконтакте](https://bitbucket.org/olegoandreev/purple-vk-plugin)
* [Wechat](https://github.com/sbwtw/pidgin-wechat)
* [WhatsApp](https://github.com/jakibaki/whatsapp-purple)
* [Yahoo](https://github.com/EionRobb/funyahoo-plusplus)
* Zephyr

Naver LINE is commented out in the Dockerfile because Naver now bans accounts using 3rd-party clients.  Uncomment it at your own risk.

## Typical Usage

For configuration persistance, `/opt/dockerdata/bitlbee` should be present on the host with sufficient permissions.

##### Using Docker CLI
```bash
docker run -d --name bitlbee --restart=always \
-v /opt/dockerdata/bitlbee:/bitlbee-data:rw \
-v /etc/localtime:/etc/localtime:ro \
-p 6667:6667 \
bclemens/bitlbee
```

Using a custom bitlbee.conf:
```bash
docker run -d --name bitlbee --restart=always \
-v /opt/dockerdata/bitlbee:/bitlbee-data:rw \
-v /opt/dockerdata/bitlbee.conf:/bitlbee.conf:ro \
-v /etc/localtime:/etc/localtime:ro \
-p 6667:6667 \
bclemens/bitlbee
```

##### Using Docker Compose
```bash
docker-compose up -d
```
