Review.destroy_all
User.destroy_all
Movie.destroy_all

seth = User.create(username: "MelSwell", email: "Smcohen82@gmail.com", password: "abc123")
icarus = User.create(username: "Icarus", email: "Icarus@icarus.com", password: "abc123")

def find_trailer_or_other_video(tmdb_id)
  
  videos = Tmdb::Movie.videos(tmdb_id)
  
  if videos.select { |v| v.type.downcase === 'trailer' }.length > 0
    
    videos.select { |v| v.type.downcase === 'trailer' }[0].key
    
  elsif videos.select { |v| v.type.downcase === 'clip' }.length > 0
    
    videos.select { |v| v.type.downcase === 'clip' }[0].key
    
  else
    
    videos[0].key
    
  end
end

def create_movie_from_tmdb_id(tmdb_id)
  
  tmdb_config = Tmdb::Configuration.get
  youtube_base_url = 'https://www.youtube.com/watch?v='
  
  movie = Tmdb::Movie.detail(tmdb_id)
  movie_cast = Tmdb::Movie.cast(tmdb_id)[0..5].map{ |a| a.name }.join(", ")
  movie_keywords = Tmdb::Movie.keywords(tmdb_id).map{ |k| k.name }.join(", ")
  movie_genres = movie.genres.map { |g| g.name }.join(", ")
  movie_trailer = find_trailer_or_other_video(tmdb_id)
  movie_director = Tmdb::Movie.crew(tmdb_id).select{ |c| c.job.downcase === "director" }[0].name

  Movie.create(
    title: movie.title, 
    average_tmdb_rating: movie.vote_average,
    tmdb_id: movie.id,
    overview: movie.overview,
    genres: movie_genres,
    release_date: movie.release_date.split("-")[0],
    cast: movie_cast,
    backdrop_img: tmdb_config.images.secure_base_url + "/original" + movie.backdrop_path,
    keywords: movie_keywords,
    trailer: youtube_base_url + movie_trailer,
    poster_img: tmdb_config.images.secure_base_url + "/original" + movie.poster_path,
    director: movie_director
  )

end



create_movie_from_tmdb_id(238)
create_movie_from_tmdb_id(16642)
create_movie_from_tmdb_id(68722)
create_movie_from_tmdb_id(11644)
create_movie_from_tmdb_id(2757)
create_movie_from_tmdb_id(968)
create_movie_from_tmdb_id(10774)
create_movie_from_tmdb_id(37799)
create_movie_from_tmdb_id(275)
create_movie_from_tmdb_id(85642)
create_movie_from_tmdb_id(592)
create_movie_from_tmdb_id(3133)
create_movie_from_tmdb_id(103328)
create_movie_from_tmdb_id(64690)
create_movie_from_tmdb_id(891)
create_movie_from_tmdb_id(14275)
create_movie_from_tmdb_id(536869)

Review.create(
  user_id: seth.id, 
  movie_id: Movie.find_by(title: "The Godfather").id, 
  rating: 10, 
  written_review: "What can be said that hasn't been said already?"
)

Review.create(
  user_id: seth.id, 
  movie_id: Movie.find_by(title: "Days of Heaven").id, 
  rating: 10, 
  written_review: "One of the most visually stunning films I've ever seen. Terrence Malick is a poet with a camera."
)

Review.create(
  user_id: icarus.id,
  movie_id: Movie.find_by(title: "Cats").id,
  rating: 10,
  written_review: "Everyone hated this movie, but for some reason I loved it."
)