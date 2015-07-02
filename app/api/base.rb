module API
  class Base < Grape::API
    include Grape::ActiveRecord::Extension

    format :json

    helpers API::Helpers::Error

    rescue_from ActiveRecord::RecordNotFound do |e|
      error_response message: e.message, status: 404
    end

    rescue_from Grape::Exceptions::Base do |e|
      error_response message: e.message, status: 400
    end

    rescue_from :all do
      error_response message: 'unknown server error', status: 500
    end

    mount API::Endpoints::Users
    mount API::Endpoints::Tasks

    # if none of the above routes are matched send 404
    route :any, '*path' do
      error!({error: 'endpoint not found'}, 404)
    end
  end
end
