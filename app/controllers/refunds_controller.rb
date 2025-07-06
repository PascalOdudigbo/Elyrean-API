class RefundsController < ApplicationController
  before_action :set_order # Ensures the parent order exists
  before_action :set_refund, only: [:show, :update, :destroy]

  # GET /orders/:order_id/refunds
  def index
    @refunds = @order.refunds.all
    render json: @refunds, include: [:approver, :return] # Include approver and return details
  end

  # GET /orders/:order_id/refunds/:id
  def show
    render json: @refund, include: [:approver, :return]
  end

  # POST /orders/:order_id/refunds
  def create
    @refund = @order.refunds.new(refund_params)

    # Set approver automatically from current authenticated user
    @refund.approver = current_user # Assuming current_user is available (e.g., from Devise, JWT auth)

    if @refund.save
      render json: @refund, status: :created, location: @refund
    else
      render json: @refund.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /orders/:order_id/refunds/:id
  def update
    # Note: Updates to refunds should be highly restricted due to their financial nature.
    # You might only allow status changes by certain roles, or disallow them entirely.
    if @refund.update(refund_params)
      render json: @refund
    else
      render json: @refund.errors, status: :unprocessable_entity
    end
  end

  private 

  def set_order
    @order = Order.find(params[:order_id])
  rescue ActiveRecord::RecordNotFound
    render json: {error: 'Order not found!'}
  end

  def set_refund
    @refund = @order.refunds.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Refund not found for this order!' }, status: :not_found
  end

  def return_params
    params.require(:return).permit(:return_id, :amount, :currency, :status, :refund_method, :stripe_refund_id)
  end
end
