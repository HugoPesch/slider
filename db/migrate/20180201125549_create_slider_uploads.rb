class CreateSliderUploads < ActiveRecord::Migration
  def change
    create_table :slider_uploads do |t|

      t.belongs_to :gallery, index: true
      t.timestamps null: false

    end
  end
end
