MU Stats Parser
===============

This is a log parser for the Mendicant University statistics course.

Usage
-----

* `git clone git://github.com/chastell/mu-stats-parser.git`
* `cd mu-stats-parser` (a wild `.rvmrc` appears and tries to use the ‘mu-stats-parser’ gemset)
* `bundle`
* get [the `GeoLiteCity.dat.gz` file](http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz) and gunzip it into `data/GeoLiteCity.dat`
* run `bin/mu-stats-parser <your-logfile> <a-dumpfile-with-parsed-logs>`
