ENV['RACK_ENV'] = 'test'

require 'airborne'
require 'faker'
require_relative '../config/environment'

load "#{ROOT}/db/seeds.rb"

Airborne.configure do |config|
  config.rack_app = API::Base
end

def sample_user
  @sample_user ||= {email_address: Faker::Internet.email,
                    first_name: Faker::Name.first_name,
                    last_name: Faker::Name.last_name}
end

def sample_task
  @sample_task ||= {user_id: User.first.id,
                    title: Faker::Hacker.verb,
                    description: Faker::Hacker.say_something_smart}
end

def invalid_emails
  @invalid_emails ||= %w(garbage garbage@ garbage@test @test.com test.com @test)
end