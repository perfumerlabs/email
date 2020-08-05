What is it
==========

This is a container providing API to send emails through external SMTP server.
This container was created to work in conjunction with [Queue](https://github.com/perfumerlabs/queue) container.

Installation
============

```bash
docker run \
-p 80:80/tcp \
-e EMAIL_HOST=example.com \
-e EMAIL_FROM=noreply@example.com \
-e SMTP_HOST=smtp \
-e SMTP_PORT=587 \
-e SMTP_USERNAME=username \
-e SMTP_PASSWORD=password \
-e SMTP_ENCRYPTION=tls \
-d perfumerlabs/email:v1.0.0
```

Environment variables
=====================

- EMAIL_HOST - server domain (without http://). Required.
- EMAIL_FROM - email which is used to set as "FROM". Required.
- SMTP_HOST - SMTP server host. Required.
- SMTP_PORT - SMTP port. Default is 25.
- SMTP_USERNAME - SMTP user login. Optional.
- SMTP_PASSWORD - SMTP user password. Optional.
- SMTP_ENCRYPTION - SMTP encryption method. "ssl" or "tls". Optional.
- SMTP_TIMEOUT - Timeout for sending message. Default is 30.
- PHP_PM_MAX_CHILDREN - number of FPM workers. Default value is 10.
- PHP_PM_MAX_REQUESTS - number of FPM max requests. Default value is 500.

Volumes
=======

This image has no volumes.

If you want to make any additional configuration of container, mount your bash script to /opt/setup.sh. This script will be executed on container setup.

Software
========

1. Ubuntu 16.04 Xenial
1. Nginx 1.16
1. PHP 7.4

API Reference
=============

### Create a message through SMTP-server

`POST /smtp`

Parameters (json):
- subject [string,required] - subject of the message.
- to [array|string,required] - message recipients.
- text [string,optional] - plain text body.
- html [string,optional] - html body.

Request example:
```javascript
{
    "subject": "Hello, world!",
    "to": ["bar@example.com"],
    "html": "<p>Lorem ipsum dolor sit amet...</p>"
}
```

Response example:

```javascript
{
    "status": true
}
```