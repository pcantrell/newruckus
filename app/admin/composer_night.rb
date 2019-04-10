ActiveAdmin.register ComposerNight do
  permit_params ComposerNight.attribute_names - %w(created_at updated_at name_for_searching)

  config.sort_order = "start_time_desc"
  index do
    selectable_column
    id_column
    column :visible
    column :location
    column :start_time
    column :slots
    column :message
    column 'Slots filled' do |cn|
      cn.signups.count
    end
    actions
  end

  show do
    default_main_content

    panel 'Signed up' do
      render 'signup_summary', composer_night: composer_night
    end

    div class: 'attributes_table' do
      panel "Presenter info" do
        render 'info_summary', composer_night: composer_night
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :location
      f.input :start_time, as: :string
      f.input :slots
      f.input :message
      f.input :visible
    end
    f.actions
  end

  {publish: true, unpublish: false}.each.with_index do |(name, visibility), index|
    batch_action name, priority: index do |selection|
      ComposerNight.transaction do
        ComposerNight.find(selection).each do |cn|
          cn.update! visible: visibility
        end
      end
      redirect_to admin_composer_nights_path
    end
  end

  action_item only: :index do
    link_to "Mass Create Composer Nights", mass_create_admin_composer_nights_path
  end

  collection_action :mass_create, method: [:get, :post] do
    return if request.method == 'GET'

    @date_errors = []
    @dates = params[:dates].split("\n").map(&:strip).reject(&:blank?).map do |raw_date|
      expected_day_of_week = nil
      if raw_date =~ /^(.*)\((.*)\) *(\d+:\d\d(am|pm))?$/
        raw_date, expected_day_of_week = $1.strip, $2.strip
      end

      date = nil
      begin
        Time.parse(raw_date)  # for format checking
        date = Time.parse("#{raw_date} #{params[:time_of_day]}")
      rescue => e
        @date_errors << "Unable to parse date #{raw_date}: #{e}"
        next
      end

      date += 1.year while date.past?

      actual_day_of_week = date.strftime("%a")
      if expected_day_of_week && actual_day_of_week.strip != expected_day_of_week
        @date_errors << "Mismatched day of week for #{raw_date}: expected #{expected_day_of_week}, got #{actual_day_of_week}"
      end

      date
    end

    return unless @date_errors.empty?

    params[:dates] = @dates.sort.map { |d| d.strftime("%Y %b %-d (%a) %l:%M%P") }.join("\n")

    return if params[:preview] || @dates.empty?

    location = Location.find(params[:location])
    ComposerNight.transaction do
      @dates.each do |date|
        ComposerNight.create!(location: location, start_time: date, slots: params[:slots], visible: false)
      end
    end

    redirect_to admin_composer_nights_path
  end

  member_action :email_info_summary, method: :post do
    AdminNotifications.delay.info_summary(resource, params[:recipients], params[:comments])
    flash[:notice] = "Info summary sent"
    redirect_to admin_composer_night_path(resource)
  end

  member_action :announcement_template do
    render 'announcement_template', layout: false, formats: [:text], locals: { event: resource }
  end

  controller do
    include Admin::CustomRedirectOnSave
  end
end
