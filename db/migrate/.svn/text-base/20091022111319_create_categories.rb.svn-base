class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
      t.string :name

      t.timestamps
    end
    news_cat=Category.create(:name=>'Site news')
    change_column :articles,:category_id,:integer,:default=>news_cat
  end

  def self.down
    change_column :articles,:category_id,:integer,:default=>0
    drop_table :categories
  end
end
