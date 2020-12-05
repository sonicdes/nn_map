class Map
  include Inesita::Component

  def init_map(node)
    my_map = $$.L.map(node).setView([51.505, -0.09], 13)
      .once("locationfound") do |event|
        e = Native(`event`)
        marker = $$.L.marker(e.latlng).addTo(e.target)
        e.target.on("click") do |ev|
          click_ev = Native(`ev`)
          marker.setLatLng(click_ev.latlng)
        end
      end
    $$.L.tileLayer('https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token=pk.eyJ1Ijoic29uaWNkZXMiLCJhIjoiY2toem1wMGYyMDd5NDJzc3dpa3Zrbzc3YyJ9.6IWCYOxayfgkYkqKvyBa2w', {
        attribution: 'Map data &copy; <a href="https://www.openstreetmap.org/">OpenStreetMap</a> contributors, <a href="https://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="https://www.mapbox.com/">Mapbox</a>',
        maxZoom: 18,
        id: 'mapbox/streets-v11',
        tileSize: 512,
        zoomOffset: -1,
        accessToken: 'pk.eyJ1Ijoic29uaWNkZXMiLCJhIjoiY2toem1wMGYyMDd5NDJzc3dpa3Zrbzc3YyJ9.6IWCYOxayfgkYkqKvyBa2w'
    }).addTo(my_map)
    after 0.01 do
      my_map.invalidateSize.locate(setView: true)
    end
  end

  def render
    # Content Wrapper
    div 'class' => 'content-wrapper' do
      div.content do
        div.mapid! hook: hook(:init_map) do
        end
      end
    end
    # End of Content Wrapper
  end
end
