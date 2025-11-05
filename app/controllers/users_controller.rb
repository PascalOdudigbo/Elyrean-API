class UsersController < ApplicationController
  before_action :set_user, only: [:update, :destroy]
  before_action :authenticate_user!, only: [:show, :create_artist_or_staff, :update, :destroy, :activate]
  before_action :authorize_business!, only: [:index, :create_artist_or_staff]

  # GET /users
  def index
    users = User.all.includes(:role, :artist_profile)
    render json: users, include: [:role, :artist_profile]
  end

  # GET /users/me
  def show
    render json: @current_user, except: [:password_digest, :created_at, :updated_at], include: [:role, :artist_profile, :addresses, :orders, :cart, :wishlist_items]
  end

  # POST /users (Sign-up)
  def create
    customer_role = Role.find_by(name: 'customer')
    return render json: { errors: ['Default customer role not found'] }, status: :unprocessable_entity unless customer_role

    @user = User.new(user_params.merge(role_id: customer_role.id, active: false))

    if @user.save
      token = JsonWebToken.encode(user_id: @user.id)
      UserMailer.with(user: @user, token:, app_name: 'Elyrean').welcome_email.deliver_later
      render json: { user: @user, token: token }, status: :created
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH /users/activate (via email token)
  def activate
    if @current_user.active
      render json: { message: 'User already active' }, status: :ok
    else
      @current_user.update(active: true)
      render json: { message: 'Account activated successfully!' }, status: :ok
    end
  end

  # POST /users/account_recovery
  def account_recovery
    @user = User.find_by(email: params[:email])
    if @user
      token = JsonWebToken.encode(user_id: @user.id)
      UserMailer.with(user: @user, token:, app_name: 'Elyrean').account_recovery_email.deliver_later
      render json: { message: 'Account recovery email sent. Please check your inbox.' }, status: :ok
    else
      render json: { errors: ['Email not found!'] }, status: :not_found
    end
  end

  # POST /users/create_artist_or_staff
  def create_artist_or_staff
    @user = User.new(user_params)
    if @user.save
      token = JsonWebToken.encode(user_id: @user.id)
      render json: { user: @user, token: token }, status: :created
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH /users/:id
  def update
    if @user == @current_user || @current_user.role.name == 'business'
      if @user.update(user_params)
        render json: @user
      else
        render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { errors: ['Unauthorized to update this user'] }, status: :forbidden
    end
  end

  # DELETE /users/:id
  def destroy
    @user.destroy
    head :no_content
  end

  # POST /login
  def login
    @user = User.find_by(email: params[:email])
    return render json: { errors: ['Account not activated. Please check your email!'] }, status: :unauthorized unless @user&.active

    if @user.authenticate(params[:password])
      token = JsonWebToken.encode(user_id: @user.id)
      user_json = @user.as_json(
        except: [:password_digest, :created_at, :updated_at],
        include: [:role, :artist_profile, :addresses, :orders, :cart, :wishlist_items]
      )
      render json: { user: user_json, token: token }, status: :ok
    else
      render json: { errors: ['Invalid email or password!'] }, status: :unauthorized
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { errors: ['User not found!'] }, status: :not_found
  end

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :role_id, :active, :stripe_customer_id)
  end
end
