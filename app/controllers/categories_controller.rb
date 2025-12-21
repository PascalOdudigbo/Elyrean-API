class CategoriesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :authorize_business!, except: [:index, :show]
  before_action :set_category, only: [:show, :update, :destroy]

  def index
    @categories = Category.all
    render json: @categories, include: [:products, :gender]
  end

  def show
    render json: @category, include: [:products, :gender]
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      render json: @category, status: :created, location: @category
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  end

  def update
    if @category.update(category_params)
      render json: @category
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @category.destroy
    head :no_content
  end

  def set_category
    @category = Category.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: {error: "Category not found"}, status: :not_found
  end

  def category_params
    params.require(:category).permit(:name, :description, :gender_id, :image, :image_public_id)
  end
end
