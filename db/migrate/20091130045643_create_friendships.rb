class CreateFriendships < ActiveRecord::Migration
  def self.up
    create_table :friendships do |t|
      t.integer :user_id, :friend_id, :null=> false
      t.boolean :xfn_friend, :xfn_acquaintance, :xfn_contact, :xfn_met, :xfn_coworker, :xfn_colleague, :xfn_coresident,
                :xfn_neighbor, :xfn_child, :xfn_parent, :xfn_sibling, :xfn_spouse, :xfn_kin, :xfn_muse, :xfn_date, :xfn_crush,
                :xfn_sweetheart, :default=>false, :null=>false

      t.timestamps
    end
    add_index :friendships, [:user_id, :friend_id]
  end

  def self.down
    drop_table :friendships
  end
end
