class ChangeAverageTmdbRatingToDecimalInMovies < ActiveRecord::Migration[6.1]
  def up
    change_column :movies, :average_tmdb_rating, :decimal
  end
  
  def down
    change_column :movies, :average_tmdb_rating, :integer
  end
end
