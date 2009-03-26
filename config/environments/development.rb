# Settings specified here will take precedence over those in config/environment.rb

# In the development environment your application's code is reloaded on
# every request.  This slows down response time but is perfect for development
# since you don't have to restart the webserver when you make code changes.
config.cache_classes = false

# Log error messages when you accidentally call methods on nil.
config.whiny_nils = true

# Show full error reports and disable caching
config.action_controller.consider_all_requests_local = true
config.action_view.debug_rjs                         = true
config.action_controller.perform_caching             = false

# Don't care if the mailer can't send
config.action_mailer.raise_delivery_errors = true

ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  :address => "mail.pranklabs.com",
  :port => 25,    
  :authentication => :login,
  :user_name => "jeremy",
  :password => "old2flav"
  }

#config.action_mailer.delivery_method = :smtp
#config.action_mailer.smtp_settings = { 
#:address => "domain.of.smtp.host.net", 
#:port => 25, 
#:domain => "domain.of.sender.net", 
#:authentication => :login, 
#:user_name => "dave", 
#:password => "secret" 
#}

ActionMailer::Base.perform_deliveries = false