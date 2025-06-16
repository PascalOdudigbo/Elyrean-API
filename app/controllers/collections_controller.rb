class CollectionsController < ApplicationController
  before_action :set_collection, only: [:show, :update, :destroy]
  
  def index
    @collections = Collection.all
    render json: @collections, include: [products: {include: [:artist]}]
  end

  def show
    render json: @collection, include: [products: {include: [:artist]}]
  end

  def create
    @collection = Collection.new(collection_params)
    if @collection.save
      render json: @collection, status: :created, location: @collection
    else
      render json: @collection.errors, status: :unprocessable_entity
    end
  end

  def update
    if @collection.update(collection_params)
      render json: @collection
    else
      render json: @collection.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @collection.destroy
    head :no_content
  end

  private

  def set_collection
    @collection = Collection.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: {error: "Collection not found"}, status: :not_found
  end

  def collection_params
    params.require(:collection).permit(:name, :description, :release_date, :active, :image, :image_public_id)
  end
end
