class Location
  include Inesita::Component

  def render
    if store.location
      text store.location['description']
    else
      text "Выберите метку, чтобы получить подробную информацию о проблеме."
    end
  end
end
