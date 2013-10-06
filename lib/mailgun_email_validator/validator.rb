require 'rest_client'

module MailgunEmailValidator
  DEFAULT_VALIDATION_OPTIONS = {:on => :save, :allow_nil => false, :allow_blank => false, :message => nil}
  
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
          res = RestClient.get "https://api:#{ENV['MAILGUN_PUBLIC_KEY']}@api.mailgun.net/v2/address/validate", {params: {address: value}}
          parsed = JSON.parse(res)
          is_valid = !parsed["is_valid"].nil? ? parsed["is_valid"] : false
          message = options[:message] ? options[:message] : "supplied email is invalid."
          record.errors.add(attr, message) if !is_valid
        rescue
          validates record, email: true
        end
      end
    end
  end
end