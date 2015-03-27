class CreateRetrancas < ActiveRecord::Migration
  def change
    create_table :retrancas do |t|
      t.string :name
      t.string :source
      t.string :body
      t.string :lead
      t.float :column
      t.float :width
      t.float :height
      t.integer :column_count
      t.integer :column_width

      t.references :jornal, index: true

      t.timestamps
    end
  end
end
