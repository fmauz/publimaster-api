class CreateDiarioOficials < ActiveRecord::Migration
  def change
    create_table :diario_oficials do |t|
      t.string :name
      t.text :observation
      t.references :state, index: true
      t.string :contact
      t.string :schedule
      t.string :source
      t.string :body
      t.string :lead
      t.float :column
      t.float :height
      t.float :width
      t.integer :column_count
      t.float :column_width

      t.timestamps
    end
  end
end
