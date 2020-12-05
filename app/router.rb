class Router
  include Inesita::Router
  CONFIG = {
    '/login' => { hide_sidebar: true }
  }

  def config
    CONFIG[path] || {}
  end

  def routes
    route '/', to: Map
    route '/add_location', to: AddLocation
  end
end
