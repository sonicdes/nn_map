class Map
  include Inesita::Component

  def init_map(node)
    return if store.view_map && !store.view_map.options.removed
    store.destroy_add_map
    store.view_map = my_map = $$.L.map(node, zoomControl: false).setView([56.291966, 43.938446], 11)
    store.add_tile_layer(store.view_map)
    store.add_location_markers

    after 0.01 do
      store.view_map.invalidateSize
    end
  end

  def render
    div.map_container hook: hook(:init_map) do
    end

    # div.content do
    #   component Location
    # end
  end
end
