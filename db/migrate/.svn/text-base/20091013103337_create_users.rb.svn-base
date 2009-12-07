class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :username,:limit=>64,:null=>false
      t.string :email,:limit=>128,:null=>false
      t.string :hashed_password,:limit=>64
      t.boolean :enabled,:default=>true,:null=>false
      t.text :profile
      t.datetime :last_login_at

      t.timestamps
    end
  add_index :users,:username
  end

  def self.down
    drop_table :users
  end
end
