class User < ActiveRecord::Base
  has_many :tasks, dependent: :destroy

  validates :email_address, :first_name, :last_name, presence: true

  validates :email_address, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i }

  validates :email_address, uniqueness: true
end