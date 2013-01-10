Party Tester
============

Simple Web application to create party records for testing.

The party records are created with unique identifiers and surnames to
ensure that test results are not influenced by other data (possibly
from previous runs of the test), since the ARDC Party Infrastructure
does not allow the deleting of previously harvested and processed
party records.

Requirements
------------

- Ruby (version 1.9.3 or later)
- Ruby on Rails (version 3.x)
- Bundler
- SQLite

Installation
------------

1. Edit the `lib/partyTester/config.rb` file to set a unique prefix
   string and identifier type for the deployment. Note: this is very
   important to ensure that the test records do not clash with test
   records created by other contributors.

2. Install gems:

        bundle install

3. Create database:

        rake db:migrate

Operation
---------

1. Start the Rails server (see below).

2. Visit the start page _http://localhost:3000/_ and create _test sets_
   and _party records_ using the Web interface. Replace "localhost" with
   the correct hostname, if necessary.

3. Harvest from the OAI-PMH feed at _http://localhost:3000/oai_

4. Stop the Rails server (see below).

### Managing the Rails server

#### Starting the rail server

The rails server can be started using:

    rails server -d

Or use the helper script:

    scripts/server.sh start

#### Stopping the rails server

The rails server can be stopped using:

    kill -s SIGINT _processID_

Where the process ID can be found in `tmp/pid/server.pid`.

Or use the helper script:

    scripts/server.sh stop

#### Restarting the rails server

    scripts/server.sh restart

#### Showing the status of the rails server

    scripts/server.sh status

Contact
-------

For more information, please contact [Hoylen Sue](mailto:h.sue@uq.edu.au)
or [The University of Queensland eResearch Lab](http://itee.uq.edu.au/~eresearch/).

Acknowledgements
----------------

This project is supported by the Australian National Data Service
([ANDS](http://www.ands.org.au/)). ANDS is supported by the Australian
Government through the National Collaborative Research Infrastructure
Strategy Program and the Education Investment Fund (EIF) Super Science
Initiative.
