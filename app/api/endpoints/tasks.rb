module API
  module Endpoints
    class Tasks < Grape::API

      resource :tasks do

        params do
          requires :task_id, type: Integer, desc: 'Task id'
        end
        route_param :task_id do

          desc 'Return a task'
          get do
            present Task.find(params[:task_id]), with: API::Entities::Task
          end

          desc 'Update a task'
          params do
            optional :title, type: String, desc: 'Title of the task'
            optional :description, type: String, desc: 'Short description of the task'
            optional :due_date, type: Date, desc: 'Due date for task'
            optional :complete_date, type: Date, desc: 'Date task was completed'
          end
          patch do
            task = Task.find(params.delete :task_id)
            if task.update(params)
              present task, with: API::Entities::Task
            else
              # blow chunks
            end
          end

          desc 'Delete a task'
          delete do
            Task.find(params[:task_id]).destroy
            body false
          end

          resource :complete do

            desc 'Mark task as completed'
            put do
              task = Task.find(params[:task_id])
              task.complete_date = Date.today
              if task.save
                present task, with: API::Entities::Task
              else
                # blow up
              end
            end

          end

          resource :reopen do

            desc 'Unmark task as completed'
            put do
              task = Task.find(params[:task_id])
              task.complete_date = nil
              if task.save
                present task, with: API::Entities::Task
              else
                # blow up
              end
            end

          end

        end

      end

    end
  end
end

