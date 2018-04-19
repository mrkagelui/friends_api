class AddUniquenessToFollowings < ActiveRecord::Migration[5.1]
  def change
  	add_index :followings, [:user_where_it_is_source_id, :user_where_it_is_audience_id], unique: true, name: 'following_index'
  end
end
