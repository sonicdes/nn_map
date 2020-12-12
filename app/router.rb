class Router
  include Inesita::Router
  CONFIG = {
    '/' => { show_infobox: true },
    '/add_location' => { show_infobox: true }
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
    route '/location_form', to: LocationForm, on_enter: method(:destroy_maps)
    route '/location/:id', to: Location, on_enter: method(:destroy_maps)
    route '/about', to: About, on_enter: method(:destroy_maps)
    route '/thanks_man', to: ThanksMan, on_enter: method(:destroy_maps)
  end
end
