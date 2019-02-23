# Advent of Code 2018: Year of the Elixir

## Run Instructions

Run the most recent day with

    docker-compose run --rm advent ./advent

This won't rebuild the image, so you may need to recompile with

    docker-compose build

Run a specific day with (for instance, for `day1`)

    docker-compose run --rm advent ./advent day1

That will run the program for that day, printing the answers as output.

To watch the tests run,

    docker-compose run --rm advent

And to get an iex shell, run

    docker-compose run --rm advent iex

Check for warnings with

    docker-compose run --rm advent mix compile --warnings-as-errors --force

And format with

    docker-compose run --rm advent mix format
