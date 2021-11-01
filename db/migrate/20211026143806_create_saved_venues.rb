class CreateSavedVenues < ActiveRecord::Migration[6.1]
  def change
    #create_join_table :users, :venues do |t|
    #  t.references :user, index: true, null: false, foreign_key: { to_table: 'users' }
    #  t.references :venue, index: true, null: false, foreign_key: { to_table: 'venues' }
    #end
    create_table :saved_venues do |t|
      t.references :user, index: true, foreign_key: {to_table: :users}
      t.references :venue, index: true, foreign_key: {to_table: :venues}
      t.timestamps
    end
  end
end
