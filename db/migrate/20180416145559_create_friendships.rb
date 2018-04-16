class CreateFriendships < ActiveRecord::Migration[5.1]
  def change
    create_table :friendships do |t|
      t.references :user_where_it_is_user1, index: true, foreign_key: { to_table: :users }
      t.references :user_where_it_is_user2, index: true, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
