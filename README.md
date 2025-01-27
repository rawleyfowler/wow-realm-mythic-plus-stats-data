# wow-realm-mythic-plus-stats-data

Turns lists of `<realm> <count>` into pretty graphs. Particularly useful when tracking
unique players realms you've played with.

## The War Within

### Season 1

![War Within Season 1](https://raw.githubusercontent.com/rawleyfowler/wow-realm-mythic-plus-stats-data/refs/heads/main/tww-season1/realms.png)

## How to run

You need to install `GD::Graph` via `cpan -I GD::Graph`. And have Perl 5.36 or later.

Then you can run it via `./realms.pl <folder>`, for instance:

```
./realms.pl tww-season1
```

## License

This project is licensed under the `ARTISTIC 2.0`, read the `LICENSE` file at the root of the project for more information.
