class CreateFollowings < ActiveRecord::Migration[6.1]
  def change
    create_table :followings do |t|
      t.references :user_id, index: true, foreign_key: {to_table: :users}
      t.references :following_user_id, index: true, foreign_key: {to_table: :users}
      t.timestamps
    end
  end
end
