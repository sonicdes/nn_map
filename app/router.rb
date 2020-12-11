class Router
  include Inesita::Router
  CONFIG = {
    '/about' => { hide_infobox: true }
  }

  def config
    CONFIG[path] || {}
  end

  def destroy_maps
    store.destroy_view_map
    store.destroy_add_map
  end

  def routes
    route '/', to: Map
    route '/add_location', to: AddLocation
    route '/about', to: About, on_enter: method(:destroy_maps)
  end
end
