class Store
  include Inesita::Injection

  attr_accessor :state, :location, :view_map, :add_map, :new_location, :all_locations, :marker

  def init
    @storage = Browser::Storage.new(JS.global, 'global_storage')
    @all_locations = @storage['all_locations'] || {}
    fetch_location_data
    @state = {}
    @location = nil
    @new_location = {'latlng' => nil, "description" => ''}
  end

  def rand_str
    [*('a'..'z'),*('0'..'9')].shuffle[0,10].join
  end

  def fetch_location_data
    Browser::HTTP.get '/data/all_locations.json?'+rand_str do |req|
      req.on :success do |res|
        res.json.each do |id,loc|
          (@all_locations[id] ||= loc).merge! loc
        end
        add_location_markers
      end
    end
  end

  def add_location_markers
    @markers ||= $$.L.markerClusterGroup
    store.all_locations.each do |id,loc|
      marker = loc['marker'] || $$.L.marker(loc['latlng'], {title: loc['description']})
      marker.unbindPopup
      marker.bindPopup loc['description']
      loc['marker'] = marker
      @markers.addLayer marker unless @markers.hasLayer(marker)
    end
    store.view_map.addLayer(@markers) unless store.view_map.hasLayer(@markers)
    after 0.01 do
      store.view_map.invalidateSize
    end
  end

  def save_location
    Browser::HTTP.post("/api/problem", @new_location.to_json) do |req|
      req.headers["Content-Type"] = "application/json"
      req.on :success do |res|
        @marker.remove
        @marker = nil
        @new_location['latlng'] = nil
        @new_location['description'] = ''
        @state[:thanks] = true
        render!
      end
    end
  end

  def destroy_view_map
    @view_map.remove if @view_map
    @view_map = nil
  end

  def destroy_add_map
    @add_map.remove if @add_map
    @marker.remove if @marker
    @add_map = nil
    @marker = nil
  end

  def set_marker(latlng)
    @marker ||= $$.L.marker(latlng).addTo(add_map)
    @marker.setLatLng(latlng)
    @new_location['latlng'] = [latlng.lat, latlng.lng]
    add_map.invalidateSize
  end

  def add_tile_layer(map)
    @tile_layer ||= $$.L.tileLayer('https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token=pk.eyJ1Ijoic29uaWNkZXMiLCJhIjoiY2toem1wMGYyMDd5NDJzc3dpa3Zrbzc3YyJ9.6IWCYOxayfgkYkqKvyBa2w', {
        attribution: 'Map data &copy; <a href="https://www.openstreetmap.org/">OpenStreetMap</a> contributors, <a href="https://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="https://www.mapbox.com/">Mapbox</a>',
        maxZoom: 18,
        id: 'mapbox/streets-v11',
        tileSize: 512,
        zoomOffset: -1,
        accessToken: 'pk.eyJ1Ijoic29uaWNkZXMiLCJhIjoiY2toem1wMGYyMDd5NDJzc3dpa3Zrbzc3YyJ9.6IWCYOxayfgkYkqKvyBa2w'
    })
    @tile_layer.addTo(map)
  end
end
