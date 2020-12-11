class Infobox
  include Inesita::Component

  def render
    div id: "infobox", class: "position-absolute m-2 p-2" do
      h4 do
        puts router.path
        case router.path
        when '/'
          "Карта городских проблем Нижнего Новгорода"
        when '/add_location'
          "Выберите точку, чтобы добавить проблему"
        end
      end

      case router.path
      when '/'
        if store.location
          p do
            store.location['description']
          end
          button type: "button", class: "btn btn-primary" do
            "Узнать подробнее"
          end
        else
          text "Выберите метку, чтобы узнать подробнее"
        end
      when '/add_location'
        if store.new_location['latlng']
          button type: "button", class: "btn btn-primary" do
            "Добавить проблему"
          end
        else
          text "Отметьте на карте точку, где существует проблема"
        end
      end
    end
  end
end
