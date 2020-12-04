# require Inesita
require 'inesita'
require 'inesita-router'


require 'browser'
require 'browser/delay'
require 'browser/socket'
require 'browser/http'
require 'browser/storage'

require 'time'

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

    div attrs do
      # component Sidebar unless router.config[:hide_sidebar]
      component router
    end

    # Scroll to Top Button
    a 'class' => 'scroll-to-top rounded', 'href' => '#page-top' do
      i 'class' => 'fas fa-angle-up' do
      end
    end

  end
end


Inesita::Browser.ready? do
  Application.mount_to(Inesita::Browser.body)
end

require "moment/moment"
require "leaflet/dist/leaflet"
require "leaflet.markercluster/dist/leaflet.markercluster"
