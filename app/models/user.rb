class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  before_save :downcase_email

  validates :name, presence: true, length: {maximum: Settings.user.maximum_of_name}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: Settings.user.maximum_of_email},
    format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: {minimum: Settings.user.minimum_of_password}

  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  def feed
    Post.feed_by_user(id).order_by
  end

  def is_user? user
    self == user
  end

  private

  def downcase_email
    self.email = email.downcase!
  end
end
