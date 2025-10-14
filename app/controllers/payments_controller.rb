class PaymentsController < ApplicationController
  before_action :set_order
  before_action :set_payment, only: [:show]

  # GET /orders/:order_id/payments/:id
  def show
    render json: @payment
  end

  # POST /orders/:order_id/payments
  def create
    @payment = @order.payments.new(payment_params)
    if @payment.save
      render json: @payment, status: :created, location: @payment
    else
      render json: @payment.errors, status: :unprocessable_entity
    end
  end

  private
  
  def set_order
    @order = Order.find(params[:order_id])
  rescue ActiveRecord::RecordNotFound
    render json: {error: 'Order not found!'}, status: :not_found
  end

  def set_payment
    @payment = @order.payments.find(params[:id])
    unless @payment
      render json: {error: 'Payment not found for this order!'}, status: :not_found
    end  
  end 

  def payment_params
    params.require(:payment).permit(:stripe_payment_id, :stripe_customer_id, :amount, :currency, :status, :payment_method)
  end
end
