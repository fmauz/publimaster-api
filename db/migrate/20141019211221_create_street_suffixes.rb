class CreateStreetSuffixes < ActiveRecord::Migration
  def change
    create_table :street_suffixes do |t|
      t.string :name

      t.timestamps
    end
  end
end
