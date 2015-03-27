class StatesController < ApplicationController
  def index
    render json: State.all, status: 200
  end
end