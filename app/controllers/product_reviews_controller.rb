class ProductReviewsController < ApplicationController
  before_action :set_product
  before_action :set_product_review, only: [:show, :update, :destroy]
  
  # GET /products/:product_id/product_reviews
  def index
    @product_reviews = @product.reviews.all
    render json: @product_reviews, include: [:user]
  end

  # GET /products/:product_id/product_reviews/:id
  def show
    render json: @product_review, include: [:user]
  end

  # POST /products/:product_id/product_reviews/:id
  def create
    @product_review = @product.reviews.new(product_review_params)
    if @product_review.save
      render json: @product_review, include: [:user], status: :created, location: @product_review
    else
      render json: @product_review.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /products/:product_id/product_reviews/:id
  def update
    if @product_review.update(product_review_params)
      render json: @product_review, include: [:user]
    else 
      render json: @product_review.errors, status: :unprocessable_entity
    end
  end

  # DELETE /products/:product_id/product_reviews/:id
  def destroy
    @product_review.destroy
    head :no_content
  end

  private

  def set_product 
    @product = Product.find(params[:product_id])
  rescue ActiveRecord::RecordNotFound
    render json: {error: 'Product not found!'}, status: :not_found
  end 

  def set_product_review
    @product_review = @product.reviews.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: {error: 'Product review not found!'}, status: :not_found
  end

  def product_review_params
    params.require(:product_review).permit(:user_id, :rating, :review)
  end
end
