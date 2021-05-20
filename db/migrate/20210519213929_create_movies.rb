class CreateMovies < ActiveRecord::Migration[6.1]
  def change
    create_table :movies do |t|
      t.string :title
      t.integer :average_tmdb_rating
      t.string :poster_img
      t.string :director
      t.integer :tmdb_id
      t.text :overview
      t.string :backdrop_img
      t.string :trailer
      t.string :cast
      t.string :genres
      t.string :keywords
      t.string :release_date

      t.timestamps
    end
  end
end
