class CreateFriends < ActiveRecord::Migration[7.0]
  def change
    create_table :friends do |t|
      t.integer :friend_id

      t.timestamps
    end
  end
end
