# OAI Record.
#
# Record class.
#
# This class is passed to the OAI ActiveRecordWrapper class
# to use.
#
# Copyright (C) 2012, The University of Queensland.
#----------------------------------------------------------------

require 'partyTester/config'
require 'partyTester/output/oaipmh/set'

module PartyTester
  module Output
    module OAIPMH

      class Record < ActiveRecord::Base

        self.table_name = 'party_records'

        # attr_accessible :key
        # attr_accessible :surname
        # attr_accessible :forename
        # attr_accessible :testident
        # attr_accessible :description
        # attr_accessible :notes
        # attr_accessible :partySet_id

#        belongs_to :party_set
#        :class_name => 'PartyTester::Merge::Concept'

#        validate :valid_rifcs?
#        after_validation :clean_metadata
#        after_save :update_set_memberships

        @@schemas = {}

        # Indicates whether delete is supported.
        #
        def deleted?
          false
        end

        # Sets supported.
        #
        def self.sets
          false

          # TODO: fix this to allow the "test sets" to appear as OAI-PMH sets
          #PartyTester::Output::OAIPMH::Set.scoped
        end

        #================================================================
        # Generate RIF-CS
        #
        def to_rif

          # Only output description element if it has a value
          if ! description.blank?
            desc = "<description type=\"full\">#{description}</description>"
          else
            desc = ''
          end

          # Use the test set prefix as the group (is this correct?)
          group = PartySet.find(partySet_id).prefix

          result = <<END

<registryObjects xmlns="http://ands.org.au/standards/rif-cs/registryObjects">
  <registryObject group="#{group}">
  <key>#{key}</key>
  <originatingSource>partyTester</originatingSource>
  <party type="person" dateModified="#{updated_at.utc.iso8601}">
    <identifier type="#{PartyTester::Config::IDENTIFIER_TYPE}">#{testident}</identifier>
    <name type="primary">
      <namePart type="family">#{surname}</namePart>
      <namePart type="given">#{forename}</namePart>
    </name>
#{desc}
  </party>
  </registryObject>
</registryObjects>
END
        end

        #================================================================
        # Methods to expose values for the Dublin Core formatter
        # (OAI::Provider::Metadata::DublinCore) to use.

        def identifier
          testident
        end

        def title
          "#{forename} #{surname}"
        end

        # Description method already provided by ActiveRecord
        #def description
        #end

      end # class Record

    end
  end
end
