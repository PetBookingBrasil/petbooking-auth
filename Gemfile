source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.4'

gem 'devise', '~> 4.7.1'
gem 'searchkick', '~> 4.1.0'
gem 'rails', '~> 6.0.0'
gem 'pg', '~> 1.1.4'
gem 'puma', '~> 3.11'
gem 'bootsnap', '>= 1.4.2', require: false

# gem 'rack-cors'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'annotate', '~> 3.0.2'
  gem 'byebug', '~> 11.0.1', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rubocop', '~> 0.75.1'
  gem 'better_errors', '~> 2.5.1'
  gem 'factory_bot_rails', '~> 5.1.1'
  gem 'rspec-rails', '~> 3.9.0'
  gem 'faker', '~> 2.6.0'
  gem 'database_cleaner', '~> 1.7.0'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
