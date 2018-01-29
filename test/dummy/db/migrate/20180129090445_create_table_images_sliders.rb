class CreateTableImagesSliders < ActiveRecord::Migration
  def change
    create_table :images_sliders do |t|
      t.belongs_to :slider, index: true, foreign_key: true
      t.integer :numIS
      t.timestamps
    end
  end
end
