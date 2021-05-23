class MoviesController < ApplicationController
  before_action :find_movie, only: [:show]

  def index
    render json: Movie.all.sort { |movie_a, movie_b| movie_b <=> movie_a }
  end

  def show
    render json: @movie
  end

  private

  def find_movie
    @movie = Movie.find(params[:id])
  end
end
