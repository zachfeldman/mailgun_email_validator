require 'rest_client'

module MailgunEmailValidator
  DEFAULT_VALIDATION_OPTIONS = {:on => :save, :allow_nil => false, :allow_blank => false, :message => nil}

  MAILGUN_PUBLIC_KEY = nil

  def valid_email_with_mailgun?(email)
    !! parsed_validation_response!(email)["is_valid"]
  end

  def validation_method(on)
    case on
      when :save   then :validate
      when :create then :validate_on_create
      when :update then :validate_on_update
    end
  end

  def validates_as_email_with_mailgun(*attrs)
    options = DEFAULT_VALIDATION_OPTIONS
    options.update(attrs.extract_options!.symbolize_keys)

    send(validation_method(options[:on]), options) do |record, attr, value|
      if options[:allow_nil]
        return if record.nil?
      elsif options[:allow_blank]
        return if record.blank?
      else
        begin
          parsed = parsed_validation_response!(value)
          is_valid = !parsed["is_valid"].nil? ? parsed["is_valid"] : false
          message = options[:message] ? options[:message] : "supplied email is invalid."
          record.errors.add(attr, message) if !is_valid
        rescue
          validates record, email: true
        end
      end
    end
  end

  private

  def parsed_validation_response!(email)
    res = RestClient.get "https://api:#{mailgun_public_key}@api.mailgun.net/v2/address/validate", {params: {address: email}}
    JSON.parse(res)
  end
  def mailgun_public_key
    MAILGUN_PUBLIC_KEY || ENV['MAILGUN_PUBLIC_KEY'] || raise("You need to supply your mailgun public api key")
  end
end
