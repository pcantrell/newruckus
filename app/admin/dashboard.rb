ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    columns do
      column min_width: '60%' do
        panel 'Composer Night Queue' do
          queue = ComposerNightSignup.queue.includes(:presenter)
          
          ul do
            queue.each do |signup|
              render 'admin/signup_list_item', signup: signup
            end
          end
          
          para "Queue emails:"
          blockquote style: "font-size: 85%; font-style: normal; line-height: 100%; white-space: pre-line" do
            queue.each do |s|
              text_node "#{s.presenter.name.inspect} <#{s.presenter.email}>,\n"
            end
          end
        end
      end

      column max_width: '33%' do
        panel 'Upcoming Composer Nights' do
          ComposerNight.upcoming.each do |event|
            para do
              b do
                link_to event.title, admin_composer_night_path(event)
              end
            end

            ul do
              event.signups.includes(:presenter).each do |signup|
                render 'admin/signup_list_item', signup: signup
              end
            end
          end
        end
      end
    end

  end
end
