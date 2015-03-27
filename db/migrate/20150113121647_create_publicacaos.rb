class CreatePublicacaos < ActiveRecord::Migration
  def change
    create_table :publicacaos do |t|
      t.references :client, index: true
      t.references :diario_oficial, index: true
      t.references :jornal, index: true
      t.references :diario_oficial_material, index: true
      t.references :jornal_material, index: true

      t.float :price
      t.date :publication_date_diario_oficial
      t.date :publication_date_jornal
      t.float :height_jornal
      t.float :coluna_jornal
      t.float :total_jornal

      t.timestamps
    end
  end
end
