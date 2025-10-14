class ArtistsController < ApplicationController
  before_action :set_artist, only: [:show, :update, :destroy]
  
  def index
    @artists = Artist.all
    render json: @artists, include: :user
  end

  def show
    render json: @user, include: :user
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created, location: @artist
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(artist_params)
      render json: @artist
    else
      render json: @artist.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @artist.destroy
    head :no_content
  end

  private

  def set_artist
    @artist = Artist.find(params[:id])
  rescue ActiveRecords::RecordNotFound
    return json: { error: 'Artist not found'}, status: :not_found
  end

  def artist_params
    params.require(:artist).permit(:user_id, :name, :bio, :image, :image_public_id)
  end
end
