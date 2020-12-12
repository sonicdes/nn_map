class LocationForm
  include Inesita::Component

  def render
    div.container do
      div.col_md_4 do
        form method: 'post', action: '/api/problem' do
          input type: 'hidden', name: 'lat', value: store.new_location['latlng'][0]
          input type: 'hidden', name: 'lng', value: store.new_location['latlng'][1]
          div.mb_3.mt_4 do
            label.form_label do
              "Заголовок"
            end
            input.form_control type: 'text', name: 'title' do
            end
          end
          div.mb_3 do
            label.form_label do
              "Описание проблемы"
            end
            textarea.form_control rows: 4, name: 'description' do
            end
          end
          button.btn.btn_primary type: submit do
            "Сохранить"
          end
        end
      end
    end
  end
end
