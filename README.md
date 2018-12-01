# Advent of Code 2018: Year of the Elixir

## Run Instructions

Run a particular day with

    docker-compose run dayN

(for instance, `day1`)

That will compile and run the program for that day, printing the answers as output.

To run the tests for a given day, run

    docker-compose run dayN mix test

And to just get a shell into that day's work:

    docker-compose run dayN /bin/bash

The above steps create a number of stale containers. To remove those, run

    docker-compose down