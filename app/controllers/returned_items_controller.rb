class ReturnedItemsController < ApplicationController
   before_action :set_return # Ensures the parent return exists
  before_action :set_returned_item, only: [:show, :update, :destroy]

  # GET /returns/:return_id/returned_items
  def index
    @returned_items = @return.returned_items.all
    render json: @returned_items, include: [:order_item] # Optionally include order_item details
  end

  # GET /returns/:return_id/returned_items/:id
  def show
    render json: @returned_item, include: [:order_item]
  end

  # POST /returns/:return_id/returned_items
  def create
    @returned_item = @return.returned_items.new(returned_item_params)

    if @returned_item.save
      render json: @returned_item, include: [:order_item], status: :created, location: @returned_item
    else
      render json: @returned_item.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /returns/:return_id/returned_items/:id
  def update
    if @returned_item.update(returned_item_params)
      render json: @returned_item, include: [:order_item]
    else
      render json: @returned_item.errors, status: :unprocessable_entity
    end
  end

  # DELETE /returns/:return_id/returned_items/:id
  def destroy
    @returned_item.destroy
    head :no_content
  end

  private

  # Finds the parent Return
  def set_return
    @return = Return.find(params[:return_id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Return not found!' }, status: :not_found
  end

  # Finds the specific ReturnedItem scoped to the parent Return
  def set_returned_item
    @returned_item = @return.returned_items.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Returned item not found for this return!' }, status: :not_found
  end

  def returned_item_params
    params.require(:returned_item).permit(:order_item_id, :quantity, :return_price)
  end
end
