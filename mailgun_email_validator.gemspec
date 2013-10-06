$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "mailgun_email_validator/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "mailgun_email_validator"
  s.version     = MailgunEmailValidator::VERSION
  s.authors     = ["Zach Feldman"]
  s.email       = ["zachfeldman@gmail.com"]
  s.homepage    = "http://github.com/zachfeldman/mailgun_email_validator"
  s.summary     = "Ability to validate e-mails using the Mailgun API"
  s.description = "Ability to validate e-mails using the Mailgun API with a REGEX fallback."

  s.files = Dir["{app,config,db,lib}/**/*", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.0"
  s.add_dependency "rest-client"
  s.add_dependency "spectator-validates_email"
  
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec"
end
