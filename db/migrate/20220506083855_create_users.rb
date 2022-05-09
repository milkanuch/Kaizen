class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :firstname
      t.string :surname
      t.string :nickname
      t.string :email
      
      t.timestamps
    end
  end
end
