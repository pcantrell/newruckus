namespace :app do
  task create_admin: :environment do
    AdminUser.create!(
      email: ENV['admin_email'],
      password: ENV['admin_pass'],
      password_confirmation: ENV['admin_pass'])
  end

  def each_signup_from_csv
    csv_file = ENV['csv_file']
    raise "Please provide csv_file env var" if csv_file.blank?
    
    studio_z = Location.find_or_create_by!(
      name: 'Studio Z',
      url: 'http://www.studiozstpaul.com',
      address: "Northwestern Building, 2nd floor\n275 E 4th St.\nSt. Paul, MN 55101",
      map_url: 'https://www.google.com/maps/place/275+E+4th+St,+St+Paul,+MN+55101/@44.9491619,-93.085531,15z/data=!4m2!3m1!1s0x87f7d55ad3492ae9:0x6762c138c916072',
      map_image_path: 'z-map-600.png')

    CSV.foreach(csv_file, headers: true) do |row|
      if row['Name'].blank?
        p row
        next
      end

      dates = []
      9.upto(row.size) do |i|
        if row[i] =~ /Y\??/
          dates << "#{i >= 20 ? 2013 : 2014}/#{row.headers[i]}"
        end
      end

      composer_night = if dates.size == 1
        raise "wat?" unless dates.first =~ %r_(\d+)/(\d+)/(\d+)_
        year, month, day = $1, $2, $3
        ComposerNight.find_or_create_by!(
          start_time: Time.local(year, month, day, 19),
          location: studio_z,
          slots: 4)
      else
        nil
      end

      person = if row['Email Address'].blank?
        Person.find_or_create_by!(name: row['Name'])
      else
        Person.find_or_create_by!(
          email: row['Email Address'], 
          name: row['Name'])
      end

      yield row, person, composer_night
    end
  end

  task import: :environment do
    ComposerNight.transaction do
      each_signup_from_csv do |row, person, composer_night|
        signup = Signup.create!(
          presenter:      person,
          composer_night: composer_night,
          comments:       row['Comments or questions'],
          internal_notes: row['Notes'])
        signup.created_at = row['Submitted On']
        signup.save!
      end
    end
  end

  task fix_dates: :environment do
    ComposerNight.transaction do
      each_signup_from_csv do |row, person, composer_night|
        signup = Signup.find_by(
          presenter:      person,
          composer_night: composer_night)
        signup.created_at = row['Submitted On']
        signup.save!
      end
    end
  end

  task generate_access_tokens: :environment do
    Signup.transaction do
      Signup.in_queue.each { |s| s.save! }
    end
  end
end
