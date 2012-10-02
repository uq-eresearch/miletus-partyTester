Party Tester
============

Simple Web application to create party records for testing.

Requirements
------------

- Ruby Version Manager

Installation
------------

1. Create databases:

    rake db:migrate

2. Start Rails server:

    ./bin/rails-server start

Or manually using `rails server -d`.

3. Visit the start page <http://localhost:3000/> and create _test sets_
   and _party records_ using the Web interface.

4. Harvest from the OAI-PMH feed.

