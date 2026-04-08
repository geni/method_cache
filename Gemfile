source "http://www.rubygems.org"

gemspec

group :development, :test do
  gem 'dalli'
  gem 'method_source' # for bin/test
  gem 'minitest', '~> 5.0'
  gem 'rake'
  gem 'shoulda'
  gem 'simplecov',  :require => false
  gem 'test-unit' # for shoulda-context
end

group :vscode do
# Install these locally.
#  gem 'debase',             :require => false
#  gem 'rainbow',            :require => false
#  gem 'rdbg',               :require => false
#  gem "ruby-debug-ide",     :require => false

  # VSCode ruby-lsp plugin uses these.
  # Normally they're installed by the plugin using .ruby-lsp/Gemfile
  # If we don't put them here, they'll be removed if we run bundle install
  gem 'prism', '~> 1.9.0',    :require => false
  gem 'rbs',                  :require => false
  gem 'ruby-lsp', '>=0.18.0', :require => false
  gem 'ruby-lsp-rails',       :require => false
end
