class Task < ActiveRecord::Base
  belongs_to :user

  validates :title, :description, :user, presence: true
end