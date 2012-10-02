class PartySet < ActiveRecord::Base
  attr_accessible :name, :notes, :prefix

  has_many :party_records
end
