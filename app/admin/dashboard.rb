ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: 'Dashboard'

  content title: 'Dashboard' do
    queue = Signup.in_queue.includes(:presenter)
    upcoming = ComposerNight.upcoming.includes(:signups)
    order_queue_by_signup = (params[:order_queue_by_signup].to_i > 0)
    hide_unavailable = (params[:hide_unavailable].to_i > 0)

    panel 'Scheduling' do

      para do
        span do
          if order_queue_by_signup
            link_to 'Order by Composer Night', '?order_queue_by_signup=0', class: 'button'
          else
            link_to 'Order by position in queue', '?order_queue_by_signup=1', class: 'button'
          end
        end

        span do
          if hide_unavailable
            link_to 'Show all signups', '?hide_unavailable=0', class: 'button'
          else
            link_to 'Show only rows with yes/maybe', '?hide_unavailable=1', class: 'button'
          end
        end
      end

      table class: 'schedule' do

        tr class: 'dates' do
          th
          upcoming.each do |event|
            th link_to(event.start_time.strftime('%b %-d').gsub(' ', '<br>').html_safe, admin_composer_night_path(event))
          end
          th 'Notes', width: '100%'
        end

        def scheduled_status(bool)
          bool ? 'scheduled' : 'unscheduled'
        end

        queue_order = "#{'composer_nights.start_time nulls first, ' unless order_queue_by_signup} signups.created_at"
        queue.includes(:composer_night).order(queue_order).each do |signup|
          if hide_unavailable
            statuses = upcoming.map { |event| signup.preference_for(event).status }
            next if (statuses - %w(no unknown)).none?
          end

          tr class: "presenter #{scheduled_status(signup.composer_night_id)}" do
            th link_to(signup.presenter.name, edit_admin_signup_path(signup)), class: 'presenter'
            upcoming.each do |event|
              scheduled_here = (signup.composer_night_id == event.id)
              status = signup.preference_for(event).status
              td (status == 'unknown' ? ' ' : status[0].upcase),
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
          render 'touch_base_unscheduled'

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
