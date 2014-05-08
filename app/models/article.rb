class Article < ActiveRecord::Base
  belongs_to :blog
  has_many :pictures, as: :imageable
  has_and_belongs_to_many :categories
end
