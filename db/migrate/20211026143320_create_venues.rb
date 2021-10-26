class CreateVenues < ActiveRecord::Migration[6.1]
  def change
    create_table :venues do |t|
      t.string :name
      t.string :address
      t.text :description
      t.string :attire
      t.string :price_range
      t.string :location
      t.string :image_url
      t.timestamps
    end
  end
end
