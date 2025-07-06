class RolesController < ApplicationController
    def index
        @roles = Role.all
        render json: @roles
    end

    def show
        @role = Role.find(params[:id])
        render json: @role
    rescue ActiveRecord::RecordNotFound
        render json: {error: 'Role not found!'}, status: :not_found
    end
end