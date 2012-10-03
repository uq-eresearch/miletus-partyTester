# PartyTester configuration
#
# Configuration constants.
#
# Copyright (C) 2012, The University of Queensland.
#----------------------------------------------------------------

module PartyTester
  class Config

    # Prefix used for generation of unique values (e.g. person identifier,
    # surname and RIF-CS keys).
    PREFIX_STR = 'AU-QU:TEST:'

    # Value for the `type` attibute on the RIF-CS `identifier` element
    # for the person identifier.
    IDENTIFIER_TYPE = 'AU-QU-test-party'

    # Defaults when user does not fill in any value in the forms.

    DEFAULT_SET_NAME = "Untitled"

    DEFAULT_FORENAME = "John"
    DEFAULT_SURNAME = "Citizen"

  end
end
