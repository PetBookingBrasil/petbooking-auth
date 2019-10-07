class ValueObject::Zipcode
  attr_reader :value

  def initialize(input)
    @value = input.gsub(/\D/,'') rescue nil
  end

  def to_s
    @value.present? ? "#{@value[0..4]}-#{@value[5..7]}" : ""
  end

  def as_json(*args)
    @value.as_json
  end

  private

  def method_missing(method, *args, &block)
    @value.send(method, *args, &block)
  end
end
