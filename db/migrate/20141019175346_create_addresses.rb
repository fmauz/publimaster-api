class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|

      t.string :street_address
      t.string :secondary_address
      t.string :building_number
      t.string :neighborhood
      t.references :city, index: true
      t.references :state, index: true
      t.references :street_suffix, index: true
      t.string :zipcode

      t.timestamps
    end
  end
end
