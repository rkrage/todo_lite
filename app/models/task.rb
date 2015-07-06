class Task < ActiveRecord::Base
  belongs_to :user

  validates :title, :description, :user, presence: true

  scope :complete, -> { where('complete_date IS NOT NULL') }
  scope :incomplete, -> { where('complete_date IS NULL') }
end