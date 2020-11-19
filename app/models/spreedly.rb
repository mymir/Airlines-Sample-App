class Spreedly
  include HTTParty
  headers 'Accept' => 'text/xml'
  headers 'Content-Type' => 'text/xml'
  basic_auth(ENV["ENVIRONMENT_KEY"], ENV["ACCESS_SECRET"])
  base_uri("#{ENV["URI"]}/v1")
  format :xml

  def self.environment_key
    ENV["ENVIRONMENT_KEY"]
  end

  def self.purchase(payment_method_token, amount, retain_on_success, currency_code="USD")
    post_transaction("purchase", payment_method_token, amount, currency_code, retain_on_success)
  end

  def self.authorize(payment_method_token, amount, currency_code="USD")
    post_transaction("authorize", payment_method_token, amount, currency_code)
  end

  def self.get_payment_method(token)
    self.get("/payment_methods/#{token}.xml")
  end

  def self.add_payment_method_url
    "#{ENV["URI"]}/v1/payment_methods"
  end

  private
  def self.to_xml_params(hash)
    hash.collect do |key, value|
      tag = key.to_s.tr('_', '-')
      result = "<#{tag}>"
      if value.is_a?(Hash)
        result << to_xml_params(value)
      else
        result << value.to_s
      end
      result << "</#{tag}>"
      result
    end.join('')
  end

  def self.post_transaction(action, payment_method_token, amount, currency_code="USD", retain_on_success=false)
    transaction = { :amount => amount, :currency_code => currency_code, :payment_method_token => payment_method_token, retain_on_success: retain_on_success }
    self.post("/gateways/#{ENV["GATEWAY_TOKEN"]}/#{action}.xml", :body => self.to_xml_params(:transaction => transaction))
  end

end
