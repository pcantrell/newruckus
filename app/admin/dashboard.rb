ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "dashboard_default_message" do
      span class: "blank_slate" do
        span I18n.t("active_admin.dashboard_welcome.welcome")
        small I18n.t("active_admin.dashboard_welcome.call_to_action")
      end
    end

    columns do
      column do
        panel 'Composer Night Queue' do
          queue = ComposerNightSignup.queue.includes(:presenter)
          
          ul do
            queue.each do |signup|
              li(class: 'signup') do
                span link_to(signup.presenter.name, edit_admin_composer_night_signup_path(signup))
                span signup.comments, class: 'notes'
                span signup.internal_notes, class: 'notes internal'
              end
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

      column do
        panel 'Upcoming Composer Nights' do
          ComposerNight.upcoming.each do |event|
            para do
              b do
                link_to event.title, admin_composer_night_path(event)
              end
            end

            ul do
              event.signups.includes(:presenter).each do |signup|
                li do
                  link_to signup.presenter.name, edit_admin_composer_night_signup_path(signup)
                end
              end
            end
          end
        end
      end
    end

  end
end
