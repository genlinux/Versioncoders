class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.string :title
      t.string :permalink
      t.text :body

      t.timestamps
      Page.create(:title => "RailsCoders Home",
            :permalink => "welcome-page",
            :body => "Welcome to RailsCoders")
    end
  end

  def self.down
    drop_table :pages
  end
end
