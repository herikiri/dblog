class Article < ActiveRecord::Base
  include AASM
  extend FriendlyId

  friendly_id :title, use: :slugged

  belongs_to :blog
  has_many :pictures, as: :imageable
  has_and_belongs_to_many :categories
  has_many :comments

  accepts_nested_attributes_for :categories

  mount_uploader :image, PictureUploader

  def image_changed?
    @image_changed
  end



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

  private
    def self.reset_sequence!
      ActiveRecord::Base.connection.execute("DELETE from sqlite_sequence where name = '#{table_name}'")
    end

end
