# setup sprockets

sprockets.register_engine(
  '.slim',
  Slim::Template,
  silence_deprecation: true
)

sprockets.append_path "node_modules"
ENV['SASS_PATH']="node_modules"

