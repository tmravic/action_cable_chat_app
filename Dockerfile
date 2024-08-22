FROM ruby:2.6.6 AS action_cable_app

WORKDIR app/

ARG UID=1000
ARG GID=1000

RUN bash -c "set -o pipefail && apt-get update \
    && apt-get install -y --no-install-recommends build-essential sqlite curl git libpq-dev nodejs npm \
    && gem install bundler -v 2.4.22 \
    && npm install -g yarn \
    && groupadd -g "${GID}" ruby \
    && useradd --create-home --no-log-init -u "${UID}" -g "${GID}" ruby \
    && chown ruby:ruby -R /app /usr/local/bundle/*"

COPY --chown=ruby:ruby Gemfile* ./
RUN bundle install
COPY --chown=ruby:ruby . .
RUN chown ruby:ruby -R ./*
RUN PATH="/app/docker-entrypoint.sh:${PATH}"
RUN chown +x docker-entrypoint.sh
USER ruby
ENTRYPOINT ["docker-entrypoint.sh"]
