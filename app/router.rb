class Router
  include Inesita::Router
  CONFIG = {
    '/about' => { hide_map: true }
  }

  def config
    CONFIG[path] || {}
  end

  def routes
    route '/', to: Map
    route '/add_location', to: AddLocation
    route '/about', to: About
  end
end
