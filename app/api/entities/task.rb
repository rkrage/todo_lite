module API
  module Entities
    class Task < Grape::Entity
      expose :id, :user_id, :title, :description, :due_date, :completed
    end
  end
end