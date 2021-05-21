class ReviewsController < ApplicationController
  before_action :find_review, only: [:show, :update]

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

  def update
    if @review.update(review_params)
      render json: @review
    else
      render json: @review.errors.full_messages
    end
  end

  private

  def find_review
    @review = Review.find_by(id: params[:id], user_id: params[:user_id])
  end

  def review_params
    params.permit(:user_id, :id, :written_review, :rating, :movie_id)
  end

end
