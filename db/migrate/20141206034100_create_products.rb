class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.string :image_url
      # precision is the number of digits
      # scale is number of decimal places
      t.decimal :price, precision: 10, scale: 2

      t.timestamps
    end
  end
end
