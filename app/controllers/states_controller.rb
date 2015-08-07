class StatesController < ApplicationController
	before_filter :authenticate_user!
	
  def index
    render json: State.all, status: 200
  end
end