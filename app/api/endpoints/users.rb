module Endpoints
  class Users < Grape::API

    resource :users do

      desc 'Return paginated list of users'
      get do

      end

      route_param :id do
        
        desc 'Return a user'
        get do

        end

        resource :tasks do
        
          desc 'Return paginated list of tasks for a user'
          get do

          end

          desc 'Create a task for a user'
          post do

          end
        end
      end

    end

  end
end
