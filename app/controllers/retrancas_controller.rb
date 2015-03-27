class RetrancasController < ApplicationController

  def index
    @retrancas = Retranca.all.paginate :page => params[:page]

    unless params[:jornal_id].nil?
      @retrancas = @retrancas.where( jornal_id: params[:jornal_id])
    end

    set_header_pagination( @retrancas )
    render json: @retrancas, status: 200
  end

  def create
    @retranca = Retranca.new( retranca_params )
    if @retranca.save
      render json: @retranca, status: 200
    else
      render json: @retranca.errors, status: 422
    end
  end

  def update
    @retranca = Retranca.find( params[:id] )
    @retranca.update( retranca_params )
    render json: @retranca
  end

  def destroy
    @retranca = Retranca.find( params[:id] )
    @retranca.destroy
    render json: @retranca
  end

  def show
    @retranca = Retranca.find( params[:id] )
    render json: @retranca
  end

  def retranca_params
    params.require( :retranca ).permit(:name, :body, :lead, :width, :jornal_id,
                                           :height, :source, :column_count, :column_width)
  end

end
