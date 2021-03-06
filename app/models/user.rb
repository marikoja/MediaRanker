class User < ApplicationRecord
  has_many :votes

  validates :user_name, uniqueness: {message: "User Name already in use, please enter another User Name."}

  validates :user_name, presence: { message: "You need to provide a User Name" }
end
