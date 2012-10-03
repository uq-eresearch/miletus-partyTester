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

- [Ruby Version Manager](http://rvm.io/)
    - Ruby 1.9.3

Operation
---------

1. Edit the `lib/partyTester/config.rb` file to set a unique prefix
   string and identifier type for the deployment. Note: this is very
   important to ensure that the test records do not clash with test
   records created by other deployments.

2. Create databases:

	rake db:migrate

3. Start Rails server:

    rails server -d

4. Visit the start page _http://localhost:3000/_ and create _test sets_
   and _party records_ using the Web interface.

5. Harvest from the OAI-PMH feed.

6. Stop the Rails server (the process ID can be found in _tmp/pid/server.pid_):

    kill -INT <processID>

The `bin/rails-server` script can be used to start, stop and restart
the Rails server.

Acknowledgements
----------------

This project is supported by the Australian National Data Service
([ANDS](http://www.ands.org.au/)). ANDS is supported by the Australian
Government through the National Collaborative Research Infrastructure
Strategy Program and the Education Investment Fund (EIF) Super Science
Initiative.
