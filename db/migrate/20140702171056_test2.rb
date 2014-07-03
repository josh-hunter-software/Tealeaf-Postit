class Test2 < ActiveRecord::Migration
  def change
  	add_column :posts, :url, :string, default: nil
  	add_column :posts, :title, :string, default: nil
  	add_column :posts, :description, :text, default: nil
  end
end
