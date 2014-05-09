class AddStatusAndPublishedAtToArticles < ActiveRecord::Migration
  def change
  	add_column :articles, :status, :string
  	add_column :articles, :published_at, :datetime
  end
end
