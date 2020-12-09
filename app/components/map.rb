class Map
  include Inesita::Component

  def init_map(node)
    return if store.view_map
    store.destroy_add_map
    store.view_map = my_map = $$.L.map(node).setView([56.291966, 43.938446], 11)
    store.add_tile_layer(store.view_map)

    store.add_location_markers
    after 0.01 do
      my_map.invalidateSize
    end
  end

  def render
    div.map_wrapper do
      div.map_container hook: hook(:init_map) do
        # unhook: unhook(:remove_map) do
      end
    end

    div.content do
      component Location
    end
  end
end
