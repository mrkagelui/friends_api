class AddUniquenessToBlockades < ActiveRecord::Migration[5.1]
  def change
  	add_index :blockades, [:user_where_it_is_blocker_id, :user_where_it_is_blockee_id], unique: true, name: 'blockade_index'
  end
end
