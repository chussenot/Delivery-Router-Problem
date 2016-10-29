Delivery Router Problem
========================

```ruby
#   Your goals are to:
#   1) make those tests pass,
#   2) add tests for the edge cases.
#
#   If you need help to setup the project, see: https://gist.github.com/gaeldelalleau/f486f9e5fdcece8eb36e70f23c806184
#
#   Feel free to ask us any question!
#
#   Happy hacking :)
#
#   --
#
#   Goal: delight your customers by sending riders to pick and deliver their orders
#   in less than 60 minutes (faster if you can).
#
#   Hypothesis:
#     - (x, y) coordinates are used to locate restaurants, customers and riders on a grid
#     - the distance between x=0 and x=1 is 1000 meters (1 km)
#     - the distance between two arbitrary (x,y) locations is the euclidian distance (straight line)
#     - times are expressed in minutes
#     - speeds are expressed in kilometers per hour (km/h)
#
#   Note: some other hypothesis you can make to simplify the problem:
#     - all customer orders are received at the same time (t=0)
#     - all restaurants start cooking at the same time (t=0)
#     - all riders start moving at the same time (t=0)
#     - each restaurant can cook an infinite number of meals in parallel
#     - each rider can carry an infinite amount of meals at the same time
#     - riders are ninjas! They fly over trafic jams and buildings, they never need to take
#       a break and they know how to solve a NP-complete problem in polynomial time ;)
```

Install
-------
You must run `bundle` to get all gems and start coding.
There is a python dependency to help display performance charts.
The [event notify test runner](https://bitbucket.org/eradman/entr/) `entr`
binary is used to watch changes and autorun specs.

Testing
--------
To run specs manually just do `bundle exec rspec`
or `make watch` for autorun with `entr`.

Console
-------
You can load all the stack in a Pry/Irb console with `make console` command

Tools
-----

To improve your coding style don't hesitate to use these commands:

- Tests coverage `make coverage`
- Rubycritic `make critic`
- Yard documentation `make doc`
- Rubocop as Linter `make lint`
- Bench `make bench`

More commands are available in the `Makefile`,
to see them just run `make`

![What you must do](https://img.shields.io/badge/HIRE-ME!-green.svg)
