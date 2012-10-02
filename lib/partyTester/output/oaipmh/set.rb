# OAI-PMH sets.
#
# Copyright (C) 2012, The University of Queensland.
#----------------------------------------------------------------

module PartyTester
  module Output
    module OAIPMH

      class Set < ActiveRecord::Base

        self.table_name = 'party_sets'

        attr_accessible :name, :notes, :prefix
        has_many :party_records
      end

    end
  end
end
