FROM elixir:1.7.4

RUN mkdir /app
COPY . /app
WORKDIR app

RUN mix escript.build

CMD ./advent
