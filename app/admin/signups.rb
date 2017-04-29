ActiveAdmin.register Signup do
  editable_attrs = Signup.attribute_names - %w(id created_at updated_at access_token)
  permit_params editable_attrs

  scope :all
  scope :active, default: true
  scope :in_queue
  scope :upcoming
  scope :unscheduled

  menu label: 'Signups'

  index do
    selectable_column
    id_column
    column :presenter
    column :composer_night
    column :created_at
    actions
  end

  show do
    public_url = edit_signup_url(token: signup.access_token)

    if signup.scheduled?
      scheduled_date = signup.composer_night.start_time
      panel 'Contact' do
        mail_to signup.presenter.email,
          'Contact Presenter',
          class: 'button',
          subject: "Composer Night on #{scheduled_date.strftime('%b %-d')}",
          body: "
            OK, I have you on the schedule for #{scheduled_date.strftime('%B %-d')}!

            Here is your info form:

                #{public_url}

            You can keep reusing that link to add / edit info as much as you like, so just fill in whatever you have now, and you can update it as the date approaches.

            Looking forward to hearing your music.

            Cheers,

            Paul".strip_multiline_string_indentation
      end
    end

    attributes_table do
      row 'Public URL' do
        link_to public_url, public_url
      end
      editable_attrs.each do |attr|
        row attr.sub(/_id$/, '')
      end
    end
    active_admin_comments
  end

  batch_action :touch_base_with do |selection|
    @page_title = 'Touch Base'
    render 'touch_base'
  end

  collection_action :send_touch_base, method: :post do
    preview = params[:preview]
    mailer = if preview
      SignupsMailer
    else
      SignupsMailer.delay
    end

    signups = Signup.find(params[:collection_selection])
    mails = begin
      signups.map do |signup|
        mailer.touch_base(
          signup,
          params.permit(:subject, :body).reject { |k,v| v.blank? })
      end
    rescue SignupsMailerHelper::SubstitutionError => e
      @template_error = e.message
      nil
    end

    if preview || @template_error
      @mail_previews = mails
      render 'touch_base'
    else
      flash[:notice] = "#{mails.count} emails queued."
      redirect_to admin_signups_path
    end
  end

  form do |f|
    f.inputs do
      f.input :presenter, as: :select, collection: Person.order(:name), hint: if f.object.presenter
        link_to "Edit #{f.object.presenter.name}", edit_admin_person_path(f.object.presenter)
      end

      assign_event_id = params[:assign_composer_night_id]
      old_event = nil
      if assign_event_id
        old_event = f.object.composer_night
        f.object.composer_night = ComposerNight.find(assign_event_id)
      end
      f.input :composer_night, as: :select, collection: ComposerNight.order('start_time desc'), hint: if assign_event_id
        "<span style='font-weight:bold;color:#800'>← Change Composer Night? (was #{old_event.title || 'unset'})</span>".html_safe
      elsif f.object.composer_night
        link_to "Edit #{f.object.composer_night.title}", edit_admin_composer_night_path(1)
      end

      editable_attrs.each do |attr|
        f.input attr unless attr =~ /_id$/
      end
    end
    f.actions
  end
end
