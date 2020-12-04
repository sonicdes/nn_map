class Router
  include Inesita::Router
  CONFIG = {
    '/login' => { hide_sidebar: true }
  }

  def config
    CONFIG[path] || {}
  end

  def routes
    route '/', to: Home
    route '/map_location', to: MapLocation
  end
end
