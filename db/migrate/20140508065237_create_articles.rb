class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.text :content
      t.string :status
      t.references :blog, index: true

      t.timestamps
    end
  end
end
