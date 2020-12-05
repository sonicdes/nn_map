class MapLocation
  include Inesita::Component

  def render
    # Content Wrapper
    div 'id' => 'content-wrapper', 'class' => 'd-flex flex-column' do
      # Main Content
      div 'id' => 'content' do

        # component Topbar

        # Begin Page Content
        div 'class' => 'container-fluid' do
          div.row do
            div.mapid! hook: hook(:init_map) do

            end
          end

          div.row do
            a 'class' => 'btn btn-primary btn-user btn-block', onclick: -> { store.save_location } do
              'Сохранить'
            end
          end

        end
      end
      # End of Main Content
      # Footer
      footer 'class' => 'sticky-footer bg-white' do
        div 'class' => 'container my-auto' do
          div('class' => 'copyright text-center my-auto') {
            span.some_class 'Copyright © Kosatka 2020'
          }
        end
      end
      # End of Footer
    end
    # End of Content Wrapper
  end
end
