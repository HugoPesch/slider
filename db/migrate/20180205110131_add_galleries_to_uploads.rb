class AddGalleriesToUploads < ActiveRecord::Migration
  def change
    add_foreign_key :slider_uploads, :slider_galleries, column: :gallery_id
  end
end
