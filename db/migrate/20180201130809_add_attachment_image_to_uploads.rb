class AddAttachmentImageToUploads < ActiveRecord::Migration
  def self.up
    change_table :slider_uploads do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :slider_uploads, :image
  end
end
