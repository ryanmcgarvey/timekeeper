namespace :sample_data do
  desc "Generate sample data for local development"
  task generate: :environment do
    ActiveRecord::Base.transaction do
      u = User.create(email: 'ryan@themcgarveys.io', password: 'password')

      c1 = Client.create(name: 'Potatoes')
      c1_dev = c1.client_profiles.create(user_id: u.id, name: 'Development') 
      c1_pm = c1.client_profiles.create(user_id: u.id, name: 'Product Management') 
      c1_dev.rates.create(ammount: 200)
      c1_pm.rates.create(ammount: 150)

      c2 = Client.create(name: 'Vegitables')
      c2_dev = c2.client_profiles.create(user_id: u.id, name: 'Development') 
      c2_dev.rates.create(ammount: 175)

      90.times do |i|
        date = i.days.ago.to_date
        dayoff = rand(100) < 5
        next if date.saturday? || date.sunday? || dayoff
        start_time = rand(2) == 0 ? "7:00" : "10:00"
        end_time = "12:00"
        Timelog.create!(client_profile_id: c1_dev.id, date: date, begin_time: start_time, end_time: end_time)
        start_time = "13:00"
        end_time = rand(2) == 0 ? "16:00" : "19:00"
        Timelog.create!(client_profile_id: c1_dev.id, date: date.midnight, begin_time: start_time, end_time: end_time)
      end

    end
  end
end
