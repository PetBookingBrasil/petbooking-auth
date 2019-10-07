module ValueObjectWrapper::CNPJ
  extend ActiveSupport::Concern
  include ActiveModel::Serialization

  included do
    validates :cnpj, uniqueness: true, allow_nil: true
    validate :cnpj_format, if: "cnpj.present?"
  end

  # Usamos a Gem CPF/CNPJ para formatar a entrada, e persistir apenas números na base
  def cnpj=(number)
    @cnpj = number.present? ? CNPJ.new(number) : nil
    super @cnpj.try(:stripped)
    @cnpj
  end

  # Adicionamos um método de retorno, que lê os números na base e converte para um objeto do tipo CNPJ
  def formatted_cnpj
    number = read_attribute(:cnpj)
    @formatted_cnpj ||= CNPJ.new(number) if number
  end

  def read_attribute_for_serialization(*params)
    if params == ['cnpj']
      cnpj.as_json
    else
      super *params
    end
  end

  def cnpj_format
    errors.add(:cnpj, 'Inválido') unless formatted_cnpj.valid?
  end
end
