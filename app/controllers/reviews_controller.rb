class ReviewsController < ApplicationController
  before_action :find_review, only: [:show]

  def index
    @reviews = Review.where(user_id: params[:user_id])
    if @reviews.length > 0
      render json: @reviews.sort { |r_a, r_b| r_b.id <=> r_a.id}
    else
      render json: { error: "Could not find the resource you are looking for" } 
    end
  end

  def show
    if @review
      render json: @review
    else
      render json: { error: "Could not find the resource you are looking for" }
    end
  end

  private

  def find_review
    @review = Review.find_by(id: params[:id], user_id: params[:user_id])
  end

end
