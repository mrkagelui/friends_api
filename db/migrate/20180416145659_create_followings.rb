class CreateFollowings < ActiveRecord::Migration[5.1]
  def change
    create_table :followings do |t|
      t.references :user_where_it_is_source, index: true, foreign_key: { to_table: :users }
      t.references :user_where_it_is_audience, index: true, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
