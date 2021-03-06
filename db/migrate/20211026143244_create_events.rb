class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.string :name
      t.string :address
      t.text :description
      t.string :event_type
      t.string :attire
      t.string :price_range
      t.references :venue, index: true, foreign_key: {to_table: :venues}
      t.datetime :date
      t.integer :duration
      t.decimal :latitude
      t.decimal :longitude
      t.string :image_url
      t.timestamps
    end
  end
end
