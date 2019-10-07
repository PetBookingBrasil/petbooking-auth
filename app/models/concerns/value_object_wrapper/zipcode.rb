module ValueObjectWrapper::Zipcode
  extend ActiveSupport::Concern

  included do
    # We can have zipcode starting with "0"
    validates :zipcode_length, inclusion: { :in => (7..8) }, if: ->{ zipcode.present? }
  end

  def zipcode=(zipcode)
    @zipcode = ValueObject::Zipcode.new(zipcode)
    super(@zipcode.value)
  end

  def zipcode
    @zipcode ||= ValueObject::Zipcode.new(super) if super.present?
  end

  def read_attribute_for_serialization(*params)
    if params == ['zipcode']
      zipcode.as_json
    else
      super *params
    end
  end

  private
    def zipcode_length
      zipcode.value.length
    end
end
