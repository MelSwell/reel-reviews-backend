class MovieSerializer < ActiveModel::Serializer
  attributes :id, :title, :average_tmdb_rating, :poster_img, :director, :tmdb_id, :overview, :backdrop_img, :trailer, :cast, :genres, :keywords, :release_date, :reviews
end