FROM ruby:3.1.2-slim AS base
RUN apt update -qq && apt install -y libpq-dev && rm -rf /var/lib/apt/lists/*

FROM base AS bundle
RUN apt update -qq && apt install -y build-essential \
    && gem install bundler:2.3.23

COPY Gemfile* ./
RUN --mount=type=cache,target=/vendor/cache \
    bundle install -j6 && bundle cache

FROM base
COPY --from=bundle /usr/local/bundle /usr/local/bundle
WORKDIR /app
