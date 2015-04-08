class CreateResponsibles < ActiveRecord::Migration
  def change
    remove_column :clients, :responsible 
    create_table :responsibles do |t|
      t.string :name
      t.string :sector
      t.date :birthday
      t.string :cellphone
      t.string :phone
      t.references :client, index: true

      t.timestamps
    end
  end
end
