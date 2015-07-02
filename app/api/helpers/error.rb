module API
  module Helpers
    module Error

      # these are active record validation errors
      def render_validation_error(model)
        error!({ error: model.errors.full_messages.join(', ') }, 400)
      end

    end
  end
end