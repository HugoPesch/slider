class AddUploadsToOrders< ActiveRecord::Migration
  def change
    add_foreign_key :slider_orders, :slider_uploads, column: :upload_id
  end
end
