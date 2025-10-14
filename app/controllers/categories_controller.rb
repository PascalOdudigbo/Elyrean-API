class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :update, :destroy]

  def index
    @categories = Category.all
    render json: @categories, include: :products
  end

  def show
    render json: @category, include: :products
  end

  def create
    @category = Caregory.new(category_params)
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

  def caregory_params
    params.require(:category).permit(:name, :description, :gender_id, :image, :image_public_id)
  end
end
