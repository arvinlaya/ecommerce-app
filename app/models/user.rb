class User < ApplicationRecord
  has_secure_password

  validates :first_name,
            :last_name,
            :password,
            presence: true,
            length: { minimum: 1 }
  validates :email,
            presence: true,
            uniqueness: true,
            length: { minimum: 5 },
            format: { with: URI::MailTo::EMAIL_REGEXP }
end