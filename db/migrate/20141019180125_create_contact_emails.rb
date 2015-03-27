class CreateContactEmails < ActiveRecord::Migration
  def change
    create_table :contact_emails do |t|
      t.string :email
      t.string :contact
      t.references :address, index: true
      t.references :jornal, index: true

      t.timestamps
    end
  end
end
