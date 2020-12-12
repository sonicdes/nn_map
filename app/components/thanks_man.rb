class ThanksMan
  include Inesita::Component

  def reset_new_location
    store.new_location = {'latlng' => nil, "description" => ''}
  end

  def render
    div.container hook: hook(:reset_new_location) do
      h2.mt_4 do
        "Спасибо!"
      end
      p do
        "Всё плохо"
      end
      p.text_success do
        "И всё прекрасно!"
      end
    end
  end
end
