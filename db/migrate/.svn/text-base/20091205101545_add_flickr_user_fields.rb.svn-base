class AddFlickrUserFields < ActiveRecord::Migration
  def self.up
    add_column :users, :flickr_username, :string
    add_column :users, :flickr_id, :string
  end
  
  def self.down
    remove_columns :users, :flickr_username, :flickr_id
  end
end
