class User < ApplicationRecord
  #Associations
  has_many :todos, foreign_key: :created_by
  
  #Validations
  validates_presence_of :name, :email, :password_digest
  
  has_secure_password
end
