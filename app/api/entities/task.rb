module API
  module Entities
    class Task < Grape::Entity
      format_with(:readable_date) { |dt| dt.strftime('%m/%d/%Y') unless dt.nil? }

      expose :id, :user_id, :title, :description

      with_options(format_with: :readable_date) do
        expose :due_date
        expose :complete_date
      end
    end
  end
end