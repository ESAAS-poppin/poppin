class CreateVenues < ActiveRecord::Migration[6.1]
  def change
    create_table :venues do |t|
      t.string :name
      t.string :address
      t.text :description
      t.string :venue_type
      t.string :attire
      t.string :price_range
      t.decimal :latitude
      t.decimal :longitude
      t.string :image_url
      t.references :venue_admin, index: true, foreign_key: {to_table: :venue_admins}

      t.timestamps
    end
  end
end
