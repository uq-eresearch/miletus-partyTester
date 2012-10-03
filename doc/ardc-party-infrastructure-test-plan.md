ARDC Party Infrastructure Harvesting Test Plan
==============================================

Introduction
------------

This document describes how the _UQ Research Data Collections
Registry_ project will test the harvesting of its RIF-CS over OAI-PMH
feed by the _ARDC Party Infrastructure_.

The main challenge in testing the Trove harvesting operation is that
there is no mechanism in _Trove_ to reset its state. Therefore, tests
cannot be run independently of each other, nor from previously
executions of the same test.

Trove
-----

### Scope

All testing described in this document shall only be done on the
_Trove Test_ and Trove Identities Manager Beta (TIM Beta). Testing
shall not be performed on the production deployments of _Trove_ and
the Trove Identities Manager (TIM).

### Expected behaviour

This section describes the behaviour of the _ARDC Party
Infrastructure_. It defines the terminologies used in this document
and provides a background to the tests.

For simplicity, this document will refer to the _ARDC Party
Infrastructure_ as **Trove**. Strictly speaking the _ARDC Party
Infrastructure_ uses only Trove's _People and Organisations
infrastructure_ as well as additional components.

All party records obtained by the _Trove_ harvesting process will be
referred to as the **incoming** party records.

These _incoming_ party records are first examined to determine if they
are the same as a previously harvested record or not. NLA refers to
this step as the "Part A matching rules" [NLA2012]. Incoming party
records which are the same as exactly one previously harvested party
record will be referred to as a **known** party record. If it is the
same as more than one previously harvested party records it is a
**multiply-known** party record.  Otherwise the party record will be
referred to as an **unknown** party record.

The _Unknown_ party record are processed by the automatic matching
algorithm which classifies new party records as either: **unique**,
**matched** or **indeterminate.**[^fn:indeterminate] NLA refers to
this step as the "Part B matching rules" [NLA2012].  The _unique_
party records are those for which an _identity container record_ does
not yet exist for that party. The _matched_ party records are those
for which an _identity container record_ exists and can be found for
the party. The _indeterminate_ party records are those which the
automatic matching algorithm cannot determine whether an _identity
container record_ exists or not.[^fn:identity]

With _unique_ party records, a new identity container record is
automatically created and the party record assigned to it.

With _matched_ party records, the party record is assigned to the
found identity container record.

With _indeterminate_ party records, the party record is passed to the
Trove Identities Manager (TIM).

The _known_ party records undergoes a sanity check. If it passes the
sanity check, the incoming record overlays (replaces) the
corresponding party record. **What happens if the _known_ party record
fails the sanity check has not been documented by NLA, but most likely
it will be passed to TIM.**

The _multiply-known_ party records are passed to the Trove Identities
Manager (TIM).

[^fn:indeterminate]: An _indeterminate_ party record is referred to as
an "unmatched" party record in some NLA documentation. This document
avoids that term, because it can be mistakenly interpreted as
referring to both _unique_ and _indeterminate_ party records. This
document also avoids the terms "passing" or "failing," because it is
not clear whether a _unique_ party record has passed the automatic
matching process or not.

[^fn:identity]: The term _identity container record_ is used to
emphasise its behaviour as a container of party records. It is a
synonym for the term "identity record" that appears in other
documentation.

### Summary of expected behaviour

In summary, the following outcomes can occur:

- Part A matching rules results in one of the following:
	- Unknown, Part B matching rules results in one of the following:
	    - Unique
		- Matched
		- Indeterminate
    - Known; sanity checking results in one of the following
	    - Sane
		- Not sane
	- Multiply-known

Tests
-----

### Test 1: Unknown unique

#### Description

An _unknown_ party record is harvested and automatically associated
with a new identity container record that is automatically created for it.
  
#### Pre-condition

- The _incoming_ party record **shall** have a `recordID` that has
  never previously been harvested from the same contributor
  before. The `recordID` value comes from the RIF-CS registry object
  `key` element [NLA2011].
  
- The _incoming_ party record **shall not** contain any identifiers
  (NLA Party Identifiers or other identifiers) that will cause the
  _unknown_ party record to be classified as _matched_ or
  _indeterminate_.
  
- The _incoming_ party record **shall** contain a `surname` and first
  character of `forename` that has never previously been harvested
  before.

These pre-conditions will ensure that the _incoming_ party record will
be treated as an _unknown_ party record and then be classified as a
_unique_ party record.

#### Process

1. To statisfy the preconditions, create a new party record that has a
   **new person identifier** and a **new surname/forename combination**.
   
2. Make the _incoming_ party record available for Trove to harvest.

3. Trove performs the harvest operation.

#### Post-condition

- The _incoming_ party record is associated with a new identity container
  record that was automatically created.

#### Implementation [T1:I]

An artificial `surname` should be used, so there is no possibility
that it will be the same as a surname that another contributor has
used.

Each execution of this test must use a new `surname`. Although it is
possible to change just the first letter of the `forename` (and
keeping the `surname` the same) to achieve the same effect, that
approach is limited to 26 executions of the test. It is also possible
to change the combination of `surname` and first letter of the
`forename`, but that is more complex to track.

Each execution of this test must use a new `recordID`.

Care must be taken to ensure that these conditions are satisfied
across all test executions, since there is no mechanism to reset Trove
to forget previous test executions. Either keep track of previously
used values or ensure the values will always be new (e.g. encoding
the test execution's date and time into the values).

### Test 2: Unknown matched

#### Description

An _unknown_ party record is harvested and automatically associated
with an existing identity container record.

#### Pre-condition

- Trove **shall** have an existing identity container record. It **shall** contain
  a `surname` and **should** contain a `forename`.

- The _incoming_ party record **shall** have a `recordID` that has
  never previously been harvested from the same contributor before.
  
- The _incoming_ party record **shall not** contain any identifiers
  (NLA Party Identifiers or other identifiers) that will cause the
  _unknown_ party record to be classified as _unique_ or
  _indeterminate_.
  
- The _incoming_ party record **shall** contain data to ensure that it
  matches (and only matches) the existing identity container record. That is, it
  must have the appropriate combination of name parts and existance dates.

These pre-conditions will ensure that the _incoming_ party record will
be treated as an _unknown_ party record and then be classified as a
_matched_ party record.

#### Process

1. To statisfy the preconditions, have a previously created party
record from the test set that has been successfully harvested and
allocated to an identity container record. Then create a new party
record with the **same person identifier** and **same
surname/forename combination** as that previous party record. A
different description can be added to make it easier to tell the two
party records apart. (This test probably also works even if a
different surname/forename combination is used.)

2. Make the _incoming_ party record available for Trove to harvest.

3. Trove performs the harvest operation.

#### Post-condition

- The _incoming_ party record is associated with the previously
  existing identity container record.

#### Implementation

See [Test 1: Implementation][T1:I] for notes on making the `recordID` unique.


### Test 3: Unknown indeterminate

#### Description

An _unknown_ party record is harvested and is make available in 
the _Trove Identities Manager_ (TIM).

#### Pre-condition

- Trove **shall** have an existing identity container record. It **shall** contain
  a `surname` and **shall** contain a `forename`.

- The _incoming_ party record **shall** have a `recordID` that has
  never previously been harvested from the same contributor before.
  
- The _incoming_ party record **shall not** contain any identifiers
  (NLA Party Identifiers or other identifiers) that will cause the
  _unknown_ party record to be classified as _unique_ or
  _matched_.
  
- The _incoming_ party record **shall** contain data to ensure that it
  is classified as _indeterminate_. That is, it
  must have the appropriate combination of name parts and existance dates.

These pre-conditions will ensure that the _incoming_ party record will
be treated as an _unknown_ party record and then be classified as a
_indeterminate_ party record.

#### Process

1. To statisfy the preconditions, have a previously created party
record from the test set that has been successfully harvested and
allocated to an identity container record. Then create a new party
record with a **new person identifier**, but with the **same surname**
as the existing party record.

2. Make the _incoming_ party record available for Trove to harvest.

3. Trove performs the harvest operation.

#### Post-condition

- The _incoming_ party record is made available
  in the _Trove Identities Manager_ (TIM).

#### Implementation

See [Test 1: Implementation][T1:I] for notes on making the `recordID` unique.

To ensure the _incoming_ party record is classified as _indeterminate_
it should have the same `surname` but a different `forename` to the
existing party record.


### Test 4: Known sane associated

#### Description

A _known_ party record that is associated with an identity container
record is re-harvested. The new version automatically overlays
(replaces) the old version, staying in the same identity container
record.


#### Pre-condition

- Trove **shall** have a party record that was previously harvested
  from the same contributor. That party record **shall** be associated
  with an identity container record.

- The _incoming_ party record **shall** have the same `recordID` 
  as the above existing party record.
  
- The _incoming_ party record **shall** have names that passes the
  sanity checking against the existing party record.

These pre-conditions will ensure that the _incoming_ party record will
be treated as an _known_ party record that passes the sanity check.

#### Process

1. To statisfy the preconditions, have a previously created party
record from the test set that has been successfully harvested and
allocated to an identity container record. Change any of the data
elements in that party record (except for the name).

2. Make the _incoming_ party record available for Trove to harvest.

3. Trove performs the harvest operation.

#### Post-condition

- The _incoming_ party record overlays (replaces) the existing party
  record. It is associated with the same identity container record that the
  existing party record was associated with.


### Test 5: Known sane unassociated

#### Description

A _known_ party record that is in _Trove Identities Manager_ (TIM)
awaiting manual processing is re-harvested. The new version overlays
(replaces) the old version, staying in TIM.

#### Pre-condition

- Trove **shall** have a party record that was previously harvested
  from the same contributor. That party record **shall** be available
  in the Trove Identities Manager (TIM).

- The _incoming_ party record **shall** have the same `recordID` 
  as the above existing party record.
  
- The _incoming_ party record **shall** have names that passes the
  sanity checking against the existing party record.

These pre-conditions will ensure that the _incoming_ party record will
be treated as an _known_ party record that passes the sanity check.

#### Process

1. To statisfy the preconditions, have a previously created party
record from the test set that has been successfully harvested but is
in TIM awaiting manual processing. Change any of the data elements in
that party record (except for the name).

2. Make the _incoming_ party record available for Trove to harvest.

3. Trove performs the harvest operation.

#### Post-condition

- The _incoming_ party record overlays (replaces) the existing party
  record in the Trove Identities Manager (TIM).


### Test 6: Known not-sane associated

#### Description

A _known_ party record that is already associated with an identity
container record is reharvested. But since the new version makes a
change that fails the sanity checking, the new version is made
available in the _Trove Identities Manager_ (TIM). The old version
remains unchanged and remains associated with the identity container
record.

#### Pre-condition

- Trove **shall** have a party record that was previously harvested
  from the same contributor. That party record **shall** be associated
  with an identity container record.

- The _incoming_ party record **shall** have the same `recordID` 
  as the above existing party record.
  
- The _incoming_ party record **shall** have names that fails the
  sanity checking against the existing party record.

These pre-conditions will ensure that the _incoming_ party record will
be treated as an _known_ party record and fails the sanity check.

#### Process

1. To statisfy the preconditions, have a previously created party
record from the test set that has been successfully harvested and
allocated to an identity container record. Change the surname/forename
combination (this will cause the sanity check to fail).

2. Make the _incoming_ party record available for Trove to harvest.

3. Trove performs the harvest operation.

#### Post-condition

- The _incoming_ party record appears in the Trove Identities Manager
  (TIM).
  
- The existing party record remains associated with the identity container record.


### Test 7: Known not-sane unassociated

#### Description

A _known_ party record that is in the _Trove Identities Manager_ (TIM)
awaiting manual process is re-harvested. The new version is made
available in the _Trove Identities Manager_ (TIM).  The old version is
no longer in TIM.

This test might be the same as Test 5, but is included to see if the
sanity checking plays a role in the reharvesting of party records that
are in TIM.

#### Pre-condition

- Trove **shall** have a party record that was previously harvested
  from the same contributor. That party record **shall** be available
  in the Trove Identities Manager (TIM).

- The _incoming_ party record **shall** have the same `recordID` 
  as the above existing party record.
  
- The _incoming_ party record **shall** have names that fails the
  sanity checking against the existing party record.

These pre-conditions will ensure that the _incoming_ party record will
be treated as an _known_ party record and fails the sanity check.

#### Process

1. To statisfy the preconditions, have a previously created party
record from the test set that has been successfully harvested but is
in TIM awaiting manual processing. Change the surname/forename
combination (this will cause the sanity check to fail).

2. Make the _incoming_ party record available for Trove to harvest.

3. Trove performs the harvest operation.

#### Post-condition

- The _incoming_ party record appears in TIM.

- The existing party record remains in TIM.


Excluded tests
--------------

### Multiply-known party records

There is no test for the situation involving _multiply-known_ party
records is not tested. This situation is rare and the outcome
(available in TIM) already occurs in the other test cases.

### Influence of NLA Party Identifiers

NLA Party Identifiers in an _unknown_ party record is one factor that
can affect the classification of that _unknown_ party record. There
could be zero, exactly one or more than one NLA Party Identifiers in
an _unknown_ party record. The tests described here do not treat this
factor as special, since it is not the objective of these tests to
test the behaviour of Trove.

Any NLA Party Identifier in an _incoming_ party record is not
considered in the "Part A matching rules". This might result in
inconsistent data. These tests do not test this situation, since
it is uncler how _Trove_ behaves in these situations.

### Manual processing in TIM

All of these tests do not involve manual processing of party records
in the Trove Identities Manager (TIM).

The party records that are made available in TIM are left there
unprocessed.  This is because the outcome of any manual processing
(i.e. whether it is manually associated with an existing _identity
container record_, manually associated with a new manually created
_identity container record_, left unprocessed in TIM, or deleted from
TIM) is indistinguishable by external systems.

References
----------

[NLA2011]
: National Library of Australia, _RIF-CS 1.2 to EAC-CPF Mapping_,
  published 22 July 2011.  
  <https://wiki.nla.gov.au/display/ARDCPIP/Documentation>

[NLA2012]
: National Library of Australia, _Trove Party Infrastructure: Rules
  for matching party records for Trove_, version 2.0, 20 January 2012.
  <https://wiki.nla.gov.au/display/ARDCPIP/Documentation>
