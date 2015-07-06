ENV['RACK_ENV'] = 'test'

require 'airborne'
require 'faker'
require_relative '../config/environment'

load "#{ROOT}/db/seeds.rb"

Airborne.configure do |config|
  config.rack_app = API::Base
end

SAMPLE_USER = {email_address: Faker::Internet.email,
               first_name: Faker::Name.first_name,
               last_name: Faker::Name.last_name}

SAMPLE_TASK = {user_id: User.first.id,
               title: Faker::Hacker.verb,
               description: Faker::Hacker.say_something_smart}

INVALID_EMAILS = ['garbage', 'garbage@', 'garbage@test', '@test.com', 'test.com', '@test']