class CreditCard
  include ActiveModel::Validations

  attr_accessor :first_name, :last_name, :card_type, :number, :verification_value, :month, :year, :retained
  validate :incorporate_errors_from_core

  def initialize(core_response = nil)
    @core_response = core_response
    initialize_attributes(core_response['payment_method']) if core_response
  end

  private

  def initialize_attributes(attributes = {})
    attributes.each do |key, value|
      begin
        send("#{key}=", value)
      rescue NoMethodError
      end
    end
    self.retained = attributes["data"].try(:[], "retained")
  end

  def incorporate_errors_from_core
    doc = Nokogiri::XML(@core_response.body)
    doc.search("payment_method>errors>error").each do |each|
      errors.add(each.attributes['attribute'].to_s, I18n.t(each.attributes['key']))
    end
  end
end
