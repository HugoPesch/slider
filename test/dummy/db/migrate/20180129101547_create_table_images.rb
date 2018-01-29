class CreateTableImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.text :url
      t.belongs_to :images_slider, index: true, foreign_key: true
      t.timestamps
    end
  end
end
