class Article < ActiveRecord::Base
  include AASM

  belongs_to :blog
  has_many :pictures, as: :imageable
  has_and_belongs_to_many :categories
  has_many :comments

  #mount_uploader :mage, PictureUploader

  

  scope :is_draft, -> { where(status: 'draft') }
  aasm column: 'status' do
    state :draft, initial: true
    state :published

    event :publish do
      transitions from: :draft, to: :published
    end

    event :make_draft do
      transitions from: :published, to: :draft
    end

  end

end
