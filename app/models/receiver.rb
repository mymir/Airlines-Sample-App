class Receiver < ApplicationRecord
  include HTTParty
  headers 'Accept' => 'text/xml'
  headers 'Content-Type' => 'text/xml'
  basic_auth(ENV["ENVIRONMENT_KEY"], ENV["ACCESS_SECRET"])
  base_uri("#{ENV["URI"]}/v1")
  format :xml

  def self.environment_key
    ENV["ENVIRONMENT_KEY"]
  end

  def self.deliver(payment_method_token)
    post_transaction("deliver", payment_method_token)
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

  def self.post_transaction(action, payment_method_token)
    delivery = { :payment_method_token => payment_method_token, :url => ENV["RECEIVER_URL"], :headers => "Content-Type: application/xml", :body => "{ \"card_number\": \"{{credit_card_number}}\" }" }
    self.post("/receivers/#{ENV["RECEIVER_TOKEN"]}/#{action}.xml", :body => self.to_xml_params(:delivery => delivery))
  end
end
