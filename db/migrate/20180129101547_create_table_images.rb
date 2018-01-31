class CreateTableImages < ActiveRecord::Migration
  def change
    create_table :slider_images do |t|
      t.text :url
      t.belongs_to :slider_gallery, index: true, foreign_key: true
      t.timestamps
    end
  end
end
