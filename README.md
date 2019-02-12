# Advent of Code 2018: Year of the Elixir

## Run Instructions

Run the most recent day with

    docker-compose run --rm day

This won't rebuild the image, so you may need to recompile with

    docker-compose build

Run a specific day with (for instance, for `day1`)

    docker-compose run --rm day ./advent day1

That will run the program for that day, printing the answers as output.

To watch the tests run,

    docker-compose run --rm test

And to get an iex shell, run

    docker-compose run --rm day iex
