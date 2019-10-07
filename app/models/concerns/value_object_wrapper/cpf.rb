module ValueObjectWrapper::Cpf
  extend ActiveSupport::Concern
  include ActiveModel::Serialization

  included do
    validates :cpf, associated: true, allow_nil: true
  end

  def cpf=(number)
    @cpf = number.present? ? CPF.new(number) : nil
    super @cpf.try(:number) # @cpf.number strips non-digits like '.' and '-'
    @cpf
  end

  def cpf
    number = read_attribute(:cpf)
    @cpf ||= CPF.new(number) if number
  end

  def read_attribute_for_serialization(*params)
    if params == ['cpf']
      cpf.as_json
    else
      super *params
    end
  end

end
