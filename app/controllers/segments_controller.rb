class SegmentsController < ApplicationController
  def index
    @segments = Segment.all

    unless params[:page].blank?
      @segments = @segments.paginate page: params[:page]
      set_header_pagination( @segments )
    end

    render json: @segments, status: 200
  end

  def create
    @segment = Segment.new( segment_params )
    if @segment.save
      render json: @segment, status: 200
    else
      render json: @segment.errors, status: 422
    end
  end

  def show
    @segment = Segment.find( params[:id] )
    render json: @segment
  end

  def update
    @segment = Segment.find( params[:id] )
    @segment.update( segment_params )
    if @segment.valid?
      render json: @segment
    else
      render json: @segment.errors, status: 422
    end
  end

  def destroy
    @segment = Segment.find( params[:id] )
    @segment.destroy
    render json: @segment
  end

  def segment_params
    params.permit(:name)
  end
end