class CreateSavedEvents < ActiveRecord::Migration[6.1]
  def change
    #create_table :saved_events do |t|
    #  t.belongs_to :user, foreign_key: true
    #  t.belongs_to :event, foreign_key: true
    #  t.timestamps
    #end
    create_table :saved_events do |t|
      t.references :user, index: true, foreign_key: {to_table: :users}
      t.references :event, index: true, foreign_key: {to_table: :events}
      t.timestamps
    end
  end
end
