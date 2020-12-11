class About
  include Inesita::Component

  def render
    div.container do
      p do
        "Информация о проекте"
      end
    end
  end
end
