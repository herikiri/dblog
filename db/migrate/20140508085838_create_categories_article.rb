class CreateCategoriesArticle < ActiveRecord::Migration
  def change
    create_table :categories_articles do |t|
      t.references :category, index: true
      t.references :article, index: true
    end
  end
end
