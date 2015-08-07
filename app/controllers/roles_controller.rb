class RolesController < ApplicationController
	before_filter :authenticate_user!
	
  def index
    render json: Role.all, status: 200
  end
end
