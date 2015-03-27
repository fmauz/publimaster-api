class ClientTypesController < ApplicationController
  def index
    @client_types = ClientType.all

    unless params[:page].blank?
      @client_types = @client_types.paginate page: params[:page]
      set_header_pagination( @client_types )
    end

    render json: @client_types, status: 200
  end


  def create
    @client_types = ClientType.new( client_type_params )
    if @client_types.save
      render json: @client_types, status: 200
    else
      render json: @client_types.errors, status: 422
    end
  end

  def show
    @client_types = ClientType.find( params[:id] )
    render json: @client_types
  end

  def update
    @client_types = ClientType.find( params[:id] )
    @client_types.update( client_type_params )
    if @client_types.valid?
      render json: @client_types
    else
      render json: @client_types.errors, status: 422
    end
  end

  def destroy
    @client_types = ClientType.find( params[:id] )
    @client_types.destroy
    render json: @client_types
  end

  def client_type_params
    params.permit(:name)
  end
end
