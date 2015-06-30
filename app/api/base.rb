module API
  class Base < Grape::API
    include Grape::ActiveRecord::Extension

    format :json

    mount API::Endpoints::Users
    mount API::Endpoints::Tasks
  end
end
