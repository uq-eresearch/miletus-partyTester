Party Tester
============

Overview
--------

Simple Web application to create RIF-CS _party records_ for testing
the ARDC Party Infrastructure (i.e. Trove). This application was
created to support the [test plan](doc/ardc-party-infrastructure-test-plan.md).

The party records are created with unique identifiers and surnames to
ensure that test results are not influenced by other data (possibly
from previous runs of the test), since the ARDC Party Infrastructure
does not allow the deleting of previously harvested and processed
party records.

Description
-----------

### How it works

Party Tester allows _test sets_ and _party records_ to be created.

The _test sets_ are used to isolate its _party records_ from other
_party records_ that might already be in Trove. Those other _party
records_ might come from other _test sets_ (from this or other
deployment of the Party Tester) as well as from other
contributors. Each _test set_ has an internal _prefix_ string that is
guaranteed to be unique within the deployment of Party Tester; and if
the _prefix base string_ is configured properly, it will be globally
unique.

The _party records_ uses the prefix of the _test set_ they belong
to. The prefix appears at the beginning of the RIF-CS key, at the
beginning of a local identifier, and is appended to the surname. This
ensures that the surnames are globally unique, which allows new _party
records_ to be treated by Trove's automatic matching rules as new
parties.

The form to create a new _party record_ allows a new local identifier
to be generated, or an existing local identifier (from the same _test
set_) to be reused. This feature can be used to create multiple _party
records_ for the same person, to test the effect of sanity checks that
are performed on the forename and surname.

Using new _test sets_, new _party records_ can be guaranteed to be
parties that Trove has not seen before. The RIF-CS key and surname
will be unique, so the automatic matching algorithm will treat it as a
new party.

Requirements
------------

Mandatory:

- Ruby (version 1.9.3 or later)
- Ruby on Rails (version 3.2.11 or later)
- [Bundler](http://gembundler.com)
- SQLite

Optional:

- [Ruby Version Manager (RVM)](https://rvm.io)

Installation
------------

1. Edit the `lib/partyTester/config.rb` file to set a unique prefix
   base string and identifier type for the deployment. Note: this is
   very important to ensure that the test records do not clash with
   test records created by other deployments or contributors.

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

    script/server.sh start

#### Stopping the rails server

The rails server can be stopped using:

    kill -s SIGINT processID

Where the _processID_ can be found in the file `tmp/pid/server.pid`.

Or use the helper script:

    script/server.sh stop

#### Restarting the rails server

Run the helper script with `-h` (or `--help`) for more options.

    script/server.sh --help

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
