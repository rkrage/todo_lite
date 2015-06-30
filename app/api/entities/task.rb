module API
  module Entities
    class Task < Grape::Entity
      format_with(:iso_timestamp) { |dt| dt.iso8601 unless dt.nil? }

      expose :id, :user_id, :title, :description

      with_options(format_with: :iso_timestamp) do
        expose :due_date
        expose :complete_date
      end
    end
  end
end