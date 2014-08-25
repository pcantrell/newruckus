ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: 'Dashboard'

  content title: 'Dashboard' do
    queue = Signup.in_queue.includes(:presenter)
    upcoming = ComposerNight.upcoming.includes(:signups)

    panel 'Scheduling' do
      table class: 'schedule' do

        tr class: 'dates' do
          th
          upcoming.each do |event|
            th link_to(event.short_title, admin_composer_night_path(event))
          end
          th 'Notes', width: '100%'
        end

        def scheduled_status(bool)
          bool ? 'scheduled' : 'unscheduled'
        end

        queue.each do |signup|
          tr class: "presenter #{scheduled_status(signup.composer_night_id)}" do
            th link_to(signup.presenter.name, edit_admin_signup_path(signup)), class: 'presenter'
            upcoming.each do |event|
              scheduled_here = (signup.composer_night_id == event.id)
              status = signup.preference_for(event).status
              td (scheduled_here ? '✓' : status == 'unknown' ? ' ' : status[0].upcase),
                'data-composer-night-id' => event.id,
                class: [
                  'status',
                  status,
                  scheduled_status(scheduled_here),
                  ('full' if event.full?)
                ].join(' ')
            end
            td class: 'notes' do
              div signup.comments, class: 'presenter expandable'
              div signup.internal_notes, class: 'internal'
            end
          end
        end

      end
    end

    columns do
      column min_width: '60%' do
        panel 'Composer Night Queue' do
          ul class: 'signups-summary' do
            queue.unscheduled.each do |signup|
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
