class CreateBlockades < ActiveRecord::Migration[5.1]
  def change
    create_table :blockades do |t|
      t.references :user_where_it_is_blocker, index: true, foreign_key: { to_table: :users }
      t.references :user_where_it_is_blockee, index: true, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
