class CreateUrls < ActiveRecord::Migration[7.0]
  def change
    create_table :urls do |t|
      t.string :original_url
      t.string :generated_url
      t.boolean :active

      t.timestamps
    end
  end
end
