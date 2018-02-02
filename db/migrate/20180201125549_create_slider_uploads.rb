class CreateSliderUploads < ActiveRecord::Migration
  def change
    create_table :slider_uploads do |t|
      t.belongs_to :slider_gallery, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
