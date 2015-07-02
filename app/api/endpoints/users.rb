module API
  module Endpoints
    class Users < Grape::API
      include Grape::Kaminari

      resource :users do

        desc 'Return paginated list of users'
        paginate
        get do
          present paginate(User.all), with: API::Entities::User
        end

        desc 'Create a new user'
        params do
          requires :email_address, type: String, desc: 'User email address'
          requires :first_name, type: String, desc: 'User first name'
          requires :last_name, type: String, desc: 'User last name'
        end
        post do
          user = User.new(params)
          if user.save
            present user, with: API::Entities::User
          else
            render_validation_error(user)
          end
        end

        params do
          requires :user_id, type: Integer, desc: 'User id'
        end
        route_param :user_id do

          desc 'Return a user'
          get do
            present User.find(params[:user_id]), with: API::Entities::User
          end

          desc 'Update a user'
          params do
            optional :email_address, type: String, desc: 'User email address'
            optional :first_name, type: String, desc: 'User first name'
            optional :last_name, type: String, desc: 'User last name'
          end
          patch do
            user = User.find(params.delete :user_id)
            if user.update(params)
              present user, with: API::Entities::User
            else
              render_validation_error(user)
            end
          end

          desc 'Delete a user'
          delete do
            User.find(params[:user_id]).destroy
            body false
          end

          resource :tasks do

            desc 'Return paginated list of tasks for a user'
            paginate
            params do
              optional :completed, type: Boolean, desc: 'Filter by completion status'
            end
            get do
              present paginate(User.find(params[:user_id]).tasks), with: API::Entities::Task
            end

            desc 'Create a task for a user'
            params do
              requires :title, type: String, desc: 'Title of the task'
              requires :description, type: String, desc: 'Short description of the task'
              optional :due_date, type: String, desc: 'Due date for task'
              optional :complete_date, type: String, desc: 'Date task was completed'
            end
            post do
              task = Task.new(params)
              if task.save
                present task, with: API::Entities::Task
              else
                render_validation_error(task)
              end
            end
          end
        end

      end

    end
  end
end
