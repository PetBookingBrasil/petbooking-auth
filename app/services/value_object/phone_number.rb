class ValueObject::PhoneNumber
  include ActiveModel::Model

  attr_reader :value

  # https://github.com/rails/rails/blob/v4.1.9/activemodel/lib/active_model/validations/length.rb#L42
  delegate :length, to: :@value

  validates :value, presence: true, length: { in: (10..11) }

  def initialize(input)
    @value = input.gsub(/\D/,'').gsub(/^0+(.*)/,'\1') rescue nil
  end

  # HTML views
  def to_s
    @value.present? ? "(#{@value[0..1]}) #{@value[2..5]}-#{@value[6..-1]}" : ""
  end

  # JSON views
  def as_json(*args)
    @value.as_json
  end

  # validates_associated in the parent model requires the existence of this method
  def marked_for_destruction?
    false
  end

  private

  def method_missing(method, *args, &block)
    @value.send(method, *args, &block)
  end
end
