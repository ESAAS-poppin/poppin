class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.string :name
      t.string :address
      t.text :description
      t.string :attire
      t.string :price_range
      t.references :venue, index: true, foreign_key: {to_table: :venues}
      t.date :string
      t.integer :duration
      t.string :location
      t.string :image_url
      t.timestamps
    end
  end
end
