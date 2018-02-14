class AddGalleriesToOrders < ActiveRecord::Migration
  def change
    add_foreign_key :slider_orders, :slider_galleries, column: :gallery_id
  end
end
