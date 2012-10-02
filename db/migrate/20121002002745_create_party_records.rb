class CreatePartyRecords < ActiveRecord::Migration
  def change
    create_table :party_records do |t|
      t.string :key
      t.string :surname
      t.string :forename
      t.string :testident
      t.string :description
      t.text :notes
      t.integer :partySet_id

      t.timestamps
    end
  end
end
