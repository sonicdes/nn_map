# setup sprockets

sprockets.register_engine(
  '.slim',
  Slim::Template,
  silence_deprecation: true
)

sprockets.register_engine(
  '.sass',
  Tilt::SassTemplate,
  style: :compressed
)

require "autoprefixer-rails"
AutoprefixerRails.install(sprockets)

sprockets.append_path "node_modules"
ENV['SASS_PATH']="node_modules"
