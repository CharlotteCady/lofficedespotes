source "https://rubygems.org"

ruby "2.2.3"

gem "rails", "4.2.3"
gem "pg"
gem "figaro"
gem "simple_form"
gem "country_select"
gem "high_voltage"
gem "devise"
# gem "pundit"
gem "paperclip"
gem "aws-sdk", "< 2.0"
gem 'omniauth-facebook'

gem "jquery-rails"
gem "sass-rails", "~> 5.0"
gem "uglifier"
gem "bootstrap-sass"
gem "font-awesome-sass"
gem 'font-awesome-rails'
gem "rails-i18n"
gem "devise-i18n"
gem "devise-i18n-views"
gem 'acts_as_commentable', '~> 4.0.2'
gem 'acts_as_votable', '~> 0.10.0'
gem 'friendly_id', '~> 5.1.0' # Note: You MUST use 5.0.0 or greater for Rails 4.0+
gem 'activeadmin', github: 'activeadmin'
gem 'sitemap_generator'
gem 'bootsy'


group :development, :test do
  gem "spring"
  gem "annotate"
  gem "binding_of_caller"
  gem "better_errors"
  gem "quiet_assets"
  gem "pry-byebug"
  gem "pry-rails"
  gem "letter_opener"
end

group :production do
  gem "rails_12factor", group: :production
  gem "puma",           group: :production
  gem "rack-timeout"
end
