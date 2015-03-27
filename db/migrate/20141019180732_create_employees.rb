class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string :name
      t.string :cpf
      t.references :address, index: true
      t.string :position
      t.string :enrollment
      t.date :date_of_admission
      t.date :date_of_resignation
      t.decimal :salary, :precision => 8, :scale => 2
      t.string :transportation_voucher_code
      t.decimal :price_bus_passes, :precision => 8, :scale => 2
      t.references :user, index: true
      t.text :observation

      t.timestamps
    end
  end
end
