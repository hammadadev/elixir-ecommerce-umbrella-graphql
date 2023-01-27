FROM elixir:1.14.3-otp-24-alpine

RUN apk update && \
  apk add postgresql-client

ADD . /apps

RUN apk add build-base    

# Install Phoenix packages
RUN mix local.hex --force && \
    mix local.rebar --force && \
    mix archive.install --force hex phx_new 1.6.1

WORKDIR /apps

RUN chmod +x entrypoint_dev.sh

EXPOSE 4000    

CMD ./entrypoint_dev.sh