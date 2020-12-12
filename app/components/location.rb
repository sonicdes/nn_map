class Location
  include Inesita::Component

  def location
    @location ||= store.all_locations[router.params[:id]]
  end

  def render
    div.container do
      h2.mt_4 do
        location['title']
      end
      p do
        location['description']
      end
    end
  end
end
