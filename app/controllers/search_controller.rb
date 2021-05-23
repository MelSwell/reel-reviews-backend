class SearchController < ApplicationController
  def submit
    Search.new(params[:search_term]).populate_db_with_results
    @results = Movie.all.select do |movie| 
      movie.title.downcase.include?(params[:search_term].downcase)
    end

    if @results.length > 0
      render json: @results
    else
      render json: ["Sorry, we could not find a match. Please try again."]
    end
  end
end