FROM ruby:2.6.6 AS action_cable_app

WORKDIR app/

RUN bash -c "set -o pipefail && apt-get update \
    && apt-get install -y --no-install-recommends build-essential sqlite curl git libpq-dev nodejs npm \
    && gem install bundler -v 2.4.22 \
    && npm install -g yarn"

COPY Gemfile* ./
RUN bundle install
COPY . .
ENV PATH="/app:${PATH}"
ENTRYPOINT ["/app/docker-entrypoint.sh"]