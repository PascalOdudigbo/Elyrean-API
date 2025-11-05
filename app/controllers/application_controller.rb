class ApplicationController < ActionController::API
    attr_reader :current_user
    

    private
    def authenticate_user!
      header = request.headers['Authorization']
      token = header.split(' ').last if header.present?

      begin
        decoded = JsonWebToken.decode(token)
        @current_user = User.find(decoded[:user_id])
      rescue ActiveRecord::RecordNotFound, JWT::DecodeError
        render json: { errors: ['Unauthorized, invalid, or expired token!'] }, status: :unauthorized
      end
    end

    def authorize_business!
      unless @current_user&.role&.name == 'business'
        render json: { errors: ['Only business users can perform this action!'] }, status: :forbidden
      end
    end
end

