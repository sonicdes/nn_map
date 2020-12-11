class Navbar
  include Inesita::Component

  def render
    nav 'class' => 'navbar fixed-xs-bottom navbar-dark bg-dark' do
      div.container_fluid do
        a class: "navbar-brand fs-6", href: "/" do
          "Все точки"
        end
        a class: "navbar-brand fs-6", href: "/add_location" do
          "Создать точку"
        end
        a class: "navbar-brand fs-6 me-0", href: "/about" do
          "О проекте"
        end
      end
    end



    # nav  do
    #   a.brand 'href' => '/' do
    #     span  do
    #       'NN Map'
    #     end
    #   end
    #   div 'class' => 'menu' do
    #     a 'href' => '/add_location', 'class' => 'button' do
    #       'Создать метку'
    #     end
    #     a 'href' => '/about', 'class' => 'pseudo button' do
    #       'О проекте'
    #     end
    #   end
    # end

  end
end
