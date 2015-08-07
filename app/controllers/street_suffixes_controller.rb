class StreetSuffixesController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @street_suffixes = StreetSuffix.all

    unless params[:page].blank?
      @street_suffixes = @street_suffixes.paginate page: params[:page]
      set_header_pagination( @street_suffixes )
    end

    render json: @street_suffixes, status: 200
  end

  def create
    @street_suffix = StreetSuffix.new( street_suffix_params )
    if @street_suffix.save
      render json: @street_suffix, status: 200
    else
      render json: @street_suffix.errors, status: 422
    end
  end

  def show
    @street_suffix = StreetSuffix.find( params[:id] )
    render json: @street_suffix
  end

  def update
    @street_suffix = StreetSuffix.find( params[:id] )
    @street_suffix.update( street_suffix_params )
    if @street_suffix.valid?
      render json: @street_suffix
    else
      render json: @street_suffix.errors, status: 422
    end
  end

  def destroy
    @street_suffix = StreetSuffix.find( params[:id] )
    @street_suffix.destroy
    render json: @street_suffix
  end

  def street_suffix_params
    params.permit(:name)
  end
end
