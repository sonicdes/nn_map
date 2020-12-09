source "https://rubygems.org"

gem 'puma'
gem 'rerun'
gem 'roda'
gem 'airrecord'
gem 'rufus-scheduler'
gem 'dotenv'
gem 'bugsnag'
gem 'pry'

# inesita gems
group :inesita do
  gem 'mini_racer', '>= 0.1.15'
  gem "rack-reverse-proxy", require: "rack/reverse_proxy"
  gem 'inesita'
  gem 'inesita-router', :git => 'https://github.com/sonicdes/inesita-router.git', :branch => 'upstream_rebase'
  gem 'inesita-livereload'

  # templates gems
  gem 'slim'
  gem 'sass'

  # minification gems
  gem 'uglifier'
  gem 'htmlcompressor'

  gem 'opal-browser', :git => 'https://github.com/sonicdes/opal-browser.git', :branch => 'upstream_master'
end
