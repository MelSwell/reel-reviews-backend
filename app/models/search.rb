class Search
  def initialize(string)
    @search_results = Tmdb::Search.movie(string).results[0..9]
  end

  def populate_db_with_results
    @search_results.each do |result|
      next if (
        result.backdrop_path == nil ||
        result.poster_path == nil ||
        Movie.find_by(tmdb_id: result.id) != nil
      ) 
      create_movie_from_tmdb_id(result.id) 
    end
  end

  private

  def find_trailer_or_other_video(tmdb_id)
  
    videos = Tmdb::Movie.videos(tmdb_id)

    if videos.length == 0
      nil
    else
      if videos.select { |v| v.type.downcase === 'trailer' }.length > 0
        
        videos.select { |v| v.type.downcase === 'trailer' }[0].key
        
      elsif videos.select { |v| v.type.downcase === 'clip' }.length > 0
        
        videos.select { |v| v.type.downcase === 'clip' }[0].key
        
      else
        
        videos[0].key
        
      end
    end
  end

  def find_director(tmdb_id)
    crew = Tmdb::Movie.crew(tmdb_id)
    if crew.length == 0 || crew.select{ |c| c.job.downcase == "director" }.length == 0
      "none"
    else
      crew.select{ |c| c.job.downcase === "director" }[0].name
    end
  end

  def create_movie_from_tmdb_id(tmdb_id)
  
    tmdb_config = Tmdb::Configuration.get
    youtube_base_url = 'https://www.youtube.com/embed/'
    
    movie = Tmdb::Movie.detail(tmdb_id)
    movie_cast = Tmdb::Movie.cast(tmdb_id)[0..5].map{ |a| a.name }.join(", ")
    movie_keywords = Tmdb::Movie.keywords(tmdb_id).map{ |k| k.name }.join(", ")
    movie_genres = movie.genres.map { |g| g.name }.join(", ")
    youtube_key = find_trailer_or_other_video(tmdb_id)
    movie_trailer_url = youtube_key ? youtube_base_url+youtube_key : "none"
    movie_director = find_director(tmdb_id)
  
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
      trailer: movie_trailer_url,
      poster_img: tmdb_config.images.secure_base_url + "/original" + movie.poster_path,
      director: movie_director
    )
  
  end

end