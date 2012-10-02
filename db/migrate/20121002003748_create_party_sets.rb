class CreatePartySets < ActiveRecord::Migration
  def change
    create_table :party_sets do |t|
      t.string :name
      t.string :prefix
      t.text :notes

      t.timestamps
    end
  end
end
