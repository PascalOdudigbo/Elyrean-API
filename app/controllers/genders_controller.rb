class GendersController < ApplicationController
  before_action :get_gender, only: [:show]
  def index
    @genders = Gender.all
    render json: @genders, include: :categories
  end

  def show
    render json: @gender, include: :categories
  end

  private

  def get_gender
    @gender = Gender.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: {error: "Gender not found"}, status: :not_found
  end

  def gender_params
    params.require(:gender).permit(:name)
  end
end
