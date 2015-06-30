module API
  module Entities
    class User < Grape::Entity
      expose :id, :email_address, :first_name, :last_name
    end
  end
end