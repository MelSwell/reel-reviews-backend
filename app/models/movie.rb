class Movie < ApplicationRecord
  has_many :reviews

  validates :tmdb_id, uniqueness: true
end
