class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :movie

  delegate :name, to: :user, prefix: true, allow_nil: true

  validates :movie_id, uniqueness: {scope: :user_id, message: 'can have only one comment per user'}
  validates :content, presence: true
end
