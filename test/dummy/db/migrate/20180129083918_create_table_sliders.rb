class CreateTableSliders < ActiveRecord::Migration
  def change
    create_table :sliders do |t|
      t.text :name
      t.timestamps
    end
  end
end
