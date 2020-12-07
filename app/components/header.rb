class Header
  include Inesita::Component

  def render
    # Content Wrapper
    div 'class' => 'header' do
      div 'class' => 'home-menu pure-menu pure-menu-horizontal pure-menu-fixed' do
        a 'class' => 'pure-menu-heading', 'href' => '/' do
          'Карта НН'
        end
        ul 'class' => 'pure-menu-list' do
          li 'class' => 'pure-menu-item pure-menu-selected' do
            a 'href' => '/add_location', 'class' => 'pure-menu-link' do
              'Создать метку'
            end
          end
          li 'class' => 'pure-menu-item' do
            a 'href' => '/about', 'class' => 'pure-menu-link' do
              'О проекте'
            end
          end
        end
      end
    end
    # End of Content Wrapper
  end
end
