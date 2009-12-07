class CreatePhotos < ActiveRecord::Migration
  def self.up
    create_table :photos do |t|
      t.integer :user_id
      t.string :title
      t.text :body

      t.timestamps
      #the following columns are required for attachment_fu
      t.string :content_type, :limit => 100
      t.string :filename, :path, :thumbnail, :limit=>255
      t.integer :parent_id, :size, :width, :height
    end
    add_column :users, :photos_count, :integer
  end

  def self.down
    drop_table :photos
    remove_column :users, :photos_count
  end
end
