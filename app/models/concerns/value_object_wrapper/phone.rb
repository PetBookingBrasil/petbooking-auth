module ValueObjectWrapper::Phone
  extend ActiveSupport::Concern
  include ActiveModel::Serialization

  included do
    validates :phone, associated: true, allow_nil: true
  end

  def phone=(phone)
    @phone = ValueObject::PhoneNumber.new(phone)
    super(@phone.value)
  end

  def phone
    @phone ||= ValueObject::PhoneNumber.new(super) if super.present?
  end

  def phone_ddd
    phone.first(2)
  end

  def phone_number
    if phone.length == 11
      phone.last(9)
    elsif phone.length == 10
      phone.last(8)
    end
  end

  def read_attribute_for_serialization(*params)
    if params == ['phone']
      phone.as_json
    else
      super *params
    end
  end
end
