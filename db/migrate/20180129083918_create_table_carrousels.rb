class CreateTableCarrousels < ActiveRecord::Migration
  def change
    create_table :slider_carrousels do |t|
      t.text :name
      t.timestamps
    end
  end
end
