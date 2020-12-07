class Store
  include Inesita::Injection

  attr_accessor :state, :location, :view_map, :add_map, :new_location, :all_locations, :marker

  def init
    @storage = Browser::Storage.new(JS.global, 'global_storage')
    @all_locations = @storage['all_locations'] || []
    @state = {}
    @location = nil
    @new_location = {'latlng' => nil, "description" => ''}
  end

  def save_location
    @all_locations.push @new_location.dup if @new_location
    @storage['all_locations'] = @all_locations
    @marker.remove
    @marker = nil
    @new_location['latlng'] = nil
    @new_location['description'] = ''
    @state[:thanks] = true
    render!
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
