class Post < ApplicationRecord
  attr_accessor :list_tags

  belongs_to :user

  scope :order_by, ->{order created_at: :desc}
  scope :feed_by_user, lambda{|following_ids, id|
    where "user_id IN (?) OR user_id = ?", following_ids, id
  }
  scope :search_post, lambda{|search|
    where "title LIKE ? OR content LIKE ?", "%#{search}%", "%#{search}%"}

  mount_uploader :picture, PictureUploader

  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags
  has_many :comments, dependent: :destroy

  validates :title, presence: true, length: {maximum: Settings.post.maximum_of_title}
  validates :content, presence: true, length: {maximum: Settings.post.maximum_of_content}
  validates :user, presence: true
  validate :picture_size

  def list_tags= names
    self.tags = names.split(",").map do |name|
      Tag.where(name: name.strip).first_or_create!
    end
  end

  private

  def picture_size
    return unless picture.size > Settings.post.maximum_of_size_picture.megabytes
    errors.add :picture, t(".should_be_less_than_5MB")
  end
end
