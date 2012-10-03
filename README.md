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

1. Create databases:

	rake db:migrate

2. Start Rails server (using `rails server -d` or using the provided script):

    ./bin/rails-server start

3. Visit the start page _http://localhost:3000/_ and create _test sets_
   and _party records_ using the Web interface.

4. Harvest from the OAI-PMH feed.

5. Stop the Rails server (using `kill -INT` on the process ID found in _tmp/pid/server.pid_ or using the provided script):

    ./bin/rails-server stop

The `rails-server` script also supports `status` and `restart` operations.

Acknowledgements
----------------

This project is supported by the Australian National Data Service
([ANDS](http://www.ands.org.au/)). ANDS is supported by the Australian
Government through the National Collaborative Research Infrastructure
Strategy Program and the Education Investment Fund (EIF) Super Science
Initiative.
