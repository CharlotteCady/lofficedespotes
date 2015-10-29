# ActionMailer::Base.smtp_settings = {
#   :port =>           '587',
#   :address =>        'smtp.mandrillapp.com',
#   :user_name =>      ENV['MANDRILL_USERNAME'],
#   :password =>       ENV['MANDRILL_APIKEY'],
#   :domain =>         'heroku.com',
#   :authentication => :plain
# }


ActionMailer::Base.smtp_settings = {
  address: 'smtp.postmarkapp.com',
  port: '25',
  domain: 'heroku.com',
  user_name: ENV['POSTMARK_API_TOKEN'],
  password: ENV['POSTMARK_API_TOKEN'],
  authentication: :cram_md5,
  enable_starttls_auto: true
}