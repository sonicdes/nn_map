# require Inesita
require 'inesita'
require 'inesita-router'


require 'browser'
require 'browser/delay'
require 'browser/socket'
require 'browser/http'
require 'browser/storage'

require 'time'
require 'ostruct'

# require all components
require_tree './components'

# require main parts of application
require 'store'
require 'router'


# when document is ready render application to <body>

class Application
  include Inesita::Component

  inject Store
  inject Router

  def render
    attrs = {id: 'wrapper'}
    if store.state[:dropdown_active]
      attrs.merge!({onclick: -> {store.hide_dropdowns}})
    end

    component Header

    div 'class' => 'content-wrapper' do
      component router
    end
  end
end


Inesita::Browser.ready? do
  Application.mount_to(Inesita::Browser.body)
end

require "leaflet/dist/leaflet"
require "leaflet.markercluster/dist/leaflet.markercluster"
