# mailgun_email_validator

This gem adds a ``validates_as_email_with_mailgun`` method to ActiveRecord. It first tries to verify an e-mail using the amazing Mailgun e-mail validation API and then falls back to using the [spectator_validates_email](https://github.com/spectator/validates_email) gem if it can't connect.

## Usage

Add the gem to your Rails project's Gemfile, then bundle install to get started.

`gem 'mailgun_email_validator'`

You'll need to add a ``MAILGUN_PUBLIC_KEY`` environmental variable to your system, for instance in your ``~/.bash_profile``:

``export MAILGUN_PUBLIC_KEY='f23oifj3ojo2j3ofj32ijoj2iojf3iojoi2f32'``

Alternatively, you can configure mailgun with an initializer:

In ``config/initializers/mailgun_email_validator.rb``:

``MailgunEmailValidator::MAILGUN_PUBLIC_KEY = 'f23oifj3ojo2j3ofj32ijoj2iojf3iojoi2f32'``

*Note: This is not a real Mailgun public key*


To use mailgun_email_validator inside your models:

`validates_as_email_with_mailgun :email`

You can also specify many of the usual ActiveRecord validation options including ``:on``, ``:allow_nil``, ``:allow_blank``, and ``:message``.


There is also a helper method available on all models:

``MyModel#valid_email_with_mailgun?(email) => true/false``
## Contributing to mailgun_email_validator

Pull requests welcome.
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so we don't break it in a future version unintentionally.
* Send in a pull request!


## Credits

* Zach Feldman [@zachfeldman](http://zfeldman.com)
