class CreateEntries < ActiveRecord::Migration
  def self.up
    create_table :entries do |t|
      t.integer :user_id
      t.string :title
      t.text :body
      t.integer :comments_count ,:null=>false,:default=>0

      t.timestamps
    end
    add_index :entries, :user_id
  end

  def self.down
    drop_table :entries
  end
end
