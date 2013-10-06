require "mailgun_email_validator/validator"
module MailgunEmailValidator
  class Railtie < Rails::Railtie
    initializer "mailgun_email_validator.validator" do
      ActiveRecord::Base.extend MailgunEmailValidator
    end
  end
end