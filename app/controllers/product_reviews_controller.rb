class ProductReviewsController < ApplicationController
  before_action :get_product_review, only: [:show, :update, :destroy]
  
  def index
    @product_reviews = ProductReview.all
    render json: @product_reviews
  end

  def show
    render json: @product_review
  end

  def create
    @product_review = ProductReview.new(product_review_params)
    if @product_review.save
      render json: @product_review, status: :created, location: @product_review
    else
      render json: @product_review.errors, status: :unprocessable_entity
    end
  end

  def update
    if @product_review.update(product_review_params)
      render json: @product_review
    else 
      render json: @product_review.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @product_review.destroy
    head :no_content
  end

  private

  def get_product_review
    @product_review = ProductReview.find(params[:id]), status: :found
  rescue ActiveRecord::RecordNotFound
    render json: {error: 'Product review not found!'}, status: :not_found
  end

  def product_review_params
    params.require(:product_review).permit(:product_id, :user_id, :rating, :review)
  end
end
