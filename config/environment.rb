require 'pathname'
require 'bundler'
require 'require_all'

Bundler.require(:default, ENV['RACK_ENV'] || :development)

ROOT = Pathname.new(File.expand_path('../..', __FILE__))

require_all 'app'

Grape::ActiveRecord.database_file = ROOT.join('config', 'database.yml')
