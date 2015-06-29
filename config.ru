require './config/environment'

# https://github.com/intridea/grape/issues/517#issuecomment-60969722
use ActiveRecord::ConnectionAdapters::ConnectionManagement

map '/api' do
  run API
end
