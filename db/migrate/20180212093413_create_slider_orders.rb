class CreateSliderOrders < ActiveRecord::Migration
  def change
    create_table :slider_orders do |t|
      t.belongs_to :upload, index: true
      t.belongs_to :gallery, index: true
      t.integer :order
    end
  end
end
