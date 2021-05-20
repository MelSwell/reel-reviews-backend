class Review < ApplicationRecord
  belongs_to :movie
  belongs_to :user

  validates :rating, :written_review, presence: true
  validates :written_review, length: { maximum: 500 }
  validates :rating, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 10}
  validates :user_id, uniqueness: { scope: :movie_id,
    message: "has already reviewed this movie! Please update the already existing review!" }
end
