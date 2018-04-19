class AddUniquenessToFriends < ActiveRecord::Migration[5.1]
  def change
  	add_index :friendships, [:user_where_it_is_user1_id, :user_where_it_is_user2_id], unique: true, name: 'friendship_index'
  end
end
