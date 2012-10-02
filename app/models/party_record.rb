class PartyRecord < ActiveRecord::Base
  attr_accessible :key, :surname, :forename, :testident, :description, :notes, :partySet_id

  belongs_to :party_set
end
