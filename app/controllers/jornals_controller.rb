class JornalsController < ApplicationController
  def index
    @jornals = Jornal.all

    unless params[:page].blank?
      @jornals = @jornals.paginate page: params[:page]
      set_header_pagination( @jornals )
    end

    render json: @jornals
  end

  def update
    @jornal = Jornal.find( params[:id] )
    @jornal.update( jornal_params )
    render json: @jornal
  end

  def create
    @jornal = Jornal.new( jornal_params )
    if @jornal.save
      render json: @jornal, status: 200
    else
      render json: @jornal.errors, status: 422
    end
  end

  def destroy
    @jornal = Jornal.find( params[:id] )
    @jornal.destroy
    render json: @jornal
  end

  def show
    @jornal = Jornal.find( params[:id] )
    render json: @jornal
  end

  def jornal_params
    objParam = params.require( :jornal ).permit( :name, :contact, :observation, :state_id,
      :send_schedule, :send_type, :commissioning,
      contact_phones: [ :id, :area_code, :phone_number, :extension, :is_fax, :_destroy ],
      contact_emails: [ :id, :email, :contact, :_destroy ]
    )

    objParam.to_hash.rename_keys( {
      "contact_phones" => "contact_phones_attributes",
      "contact_emails" => "contact_emails_attributes"
    })
  end
end
