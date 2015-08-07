class CitiesController < ApplicationController
	before_filter :authenticate_user!
	
  def index
    render json: State.find(params[:state_id]).cities, status: 200
  end
end