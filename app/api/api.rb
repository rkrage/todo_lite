class API < Grape::API
  include Grape::ActiveRecord::Extension
  format :json

  mount Endpoints::Users
  mount Endpoints::Tasks
end
