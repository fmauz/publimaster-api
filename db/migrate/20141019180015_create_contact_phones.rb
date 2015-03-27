class CreateContactPhones < ActiveRecord::Migration
  def change
    create_table :contact_phones do |t|
      t.string :area_code
      t.string :phone_number
      t.string :extension
      t.boolean :is_fax
      t.references :address, index: true
      t.references :jornal, index: true
      
      t.timestamps
    end
  end
end
