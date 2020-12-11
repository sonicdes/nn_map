class AddLocation
  include Inesita::Component

  def hide_thanks
    store.state[:thanks] = false
  end

  def init_map(node)
    return if store.add_map && !store.add_map.options.removed
    store.destroy_view_map
    store.add_map = my_map = $$.L.map(node, zoomControl: false).setView([56.291966, 43.938446], 11)
      .once("locationfound") do |event|
        e = Native(`event`)
        store.set_marker(e.latlng)
      end
    my_map.on("click") do |ev|
      click_ev = Native(`ev`)
      store.set_marker(click_ev.latlng)
    end
    store.add_tile_layer(store.add_map)
    after 0.01 do
      if store.new_location['latlng']
        store.set_marker store.new_location['latlng']
      else
        my_map.invalidateSize.locate(setView: true)
      end
    end
  end

  def render
    div.map_container hook: hook(:init_map) do
    end
    # div.content do
    #   form class: "pure-form pure-form-stacked", hidden: store.state[:thanks] do
    #     textarea class: "pure-input-1", placeholder: "Описание",
    #       oninput: -> (e) { store.new_location['description'] = e.target.value },
    #       value: '' do
    #     end
    #     button class: "pure-button pure-input pure-button-primary",
    #       type: "button",
    #       onclick: -> {store.save_location} do
    #       text "Сохранить"
    #     end
    #   end
    #   div hidden: !store.state[:thanks], hook: hook(:hide_thanks) do
    #     text "Спасибо! Вместе мы сделаем наш город лучше!"
    #   end
    # end
  end
end
