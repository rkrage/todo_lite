unless ENV['RACK_ENV'] == :production
  require 'faker'

  User.destroy_all

  50.times do
    User.create({email_address: Faker::Internet.email,
                 first_name: Faker::Name.first_name,
                 last_name: Faker::Name.last_name})
  end

  User.all.each do |user|
    due_date = [nil, Date.today, Date.tomorrow]
    complete_date = [nil, Date.today, Date.yesterday]
    Random.rand(0..10).times do
      Task.create({user_id: user.id,
                   title: Faker::Hacker.verb,
                   description: Faker::Hacker.say_something_smart,
                   due_date: due_date.sample,
                   complete_date: complete_date.sample})
    end
  end
end