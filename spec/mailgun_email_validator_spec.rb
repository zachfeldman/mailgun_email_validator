require 'spec_helper'

describe "MailgunEmailValidator" do

  it "validates a valid email" do
    user = User.new(email: "foo@mailgun.net")
    validate(user)
  end

  it "invalidates an invalid email" do
    user = User.new(email: "foo@mailgun")
    validate(user)
  end

end