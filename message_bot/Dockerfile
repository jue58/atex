FROM ruby:3.1

RUN apt-get update && apt-get install -y busybox-static libsodium-dev

WORKDIR /app

COPY --chmod=777 ./entrypoint.sh /
COPY ./app/ /app/
COPY --chown=root:root ./crontab /var/spool/cron/crontabs/root

RUN bundle install

CMD ["/entrypoint.sh"]
