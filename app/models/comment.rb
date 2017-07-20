class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  scope :created_time_sort, ->{order created_at: :desc}

  validates :content, presence: true, length: {maximum: Settings.comment.maximum_of_content}
end
