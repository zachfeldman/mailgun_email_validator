# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

require File.expand_path("../dummy/config/environment.rb",  __FILE__)

Rails.backtrace_cleaner.remove_silencers!

RSpec.configure do |config|
  config.include ActiveSupport::Concern
  config.include MailgunEmailValidator::Validator
end