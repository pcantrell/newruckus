class SignupsMailer < ActionMailer::Base
  default from: "The New Ruckus <the@newruckus.org>"

  def edit_link(signup)
    @signup = signup
    
    required_info = {
      'Name of the music’s composer / improviser / songwriter / sound artist / mastermind / inventor' => signup.presenter.name,
      'Title(s)'       => signup.title,
      'Performer(s)'   => signup.performers,
      'Approx. length' => signup.approx_length,
      'Special needs'  => signup.special_needs
    }.to_a
    optional_info = {
      'Brief description of piece' => signup.description,
      'Composer web site'          => signup.presenter.url,
      'Composer bio'               => signup.presenter.bio
    }.to_a
    @required_info_missing = required_info.select { |k,v| v.blank? }
    @optional_info_missing = optional_info.select { |k,v| v.blank? }
    @info_provided = (required_info + optional_info).reject { |k,v| v.blank? }

    signup_mail signup, subject: "Your Composer Night signup info" do |format|
      format.html do
        if signup.scheduled?
          render 'edit_upcoming'
        else
          render 'edit_unscheduled'
        end
      end
    end
  end

private

  def signup_mail(signup, opts, &block)
    mail opts.reverse_merge(to: "#{signup.presenter.name.inspect} <#{signup.presenter.email}>"), &block
  end
end
