class Map
  include Inesita::Component

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
