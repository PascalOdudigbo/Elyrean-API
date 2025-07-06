class ReturnsController < ApplicationController
  before_action :set_order
  before_action :set_return, only: [:show, :update]
  
  # GET /orders/:order_id/returns/
  def index
    @returns = @order.returns.all 
    render json: @returns, include: [:returned_items]
  end

  # GET /orders/:order_id/returns/:id
  def show
    render json: @return, include: [:returned_items]
  end

  # POST /orders/:order_id/returns/
  def create
    @return = @order.returns.new(return_params)
    if @return.save # total_amount_returned is calculated in the model before saving
      render json: @return, status: :created, location: @return
    else
      render json: @return.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /orders/:order_id/returns/:id
  def update
    if @return.update(return_params)
      render json: @return
    else
      render json: @return.errors, status: :unprocessable_entity
    end
  end

  private

  def set_order
    @order = Order.find(params[:order_id])
  rescue ActiveRecord::RecordNotFound
    render json: {error: 'Order not found!'}
  end

  def set_return
    @return = @order.returns.find(params[:id])
    unless @return
      render json: {error: 'Return not found for this order!'}, status: :not_found
    end  
  end 

  def return_params
    params.require(:return).permit(:reason, :status, :return_date)
  end
end
