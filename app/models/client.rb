class Client < ActiveRecord::Base
  belongs_to :client_type
  belongs_to :address, dependent: :destroy
  belongs_to :segment
  belongs_to :employee

  accepts_nested_attributes_for :address

  default_scope ->{ order( :name ) }

  validates :name,
            :cpf_cnpj,
            :client_type,
            :address,
            :segment,
            :employee,
            presence: true

  def self.search( query )
    if !query.blank?
      joins(:segment)
      .where( 
              self.arel_table[:name].matches( "%#{query}%" )
                .or( self.arel_table[:cpf_cnpj].eq( query ) )
                .or( Segment.arel_table[:name].eq( query ) )
                .or( self.arel_table[:client_group].eq( query ) )
           )
    else
      self
    end
  end
end
