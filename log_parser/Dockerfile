FROM fluentd:v1.14-1

USER root

RUN gem install fluent-plugin-redis-store

USER fluent

COPY ./fluent.conf /fluentd/etc/fluent.conf
