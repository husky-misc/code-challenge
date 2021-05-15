class User < ApplicationRecord
  self.table_name = :users

  include ActiveModel::SecurePassword

  VALID_EMAIL_FORMAT = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i.freeze

  with_options presence: true do
    validates :password, length: { minimum: 6 }
    validates :email, length: { maximum: 260 }, format: { with: VALID_EMAIL_FORMAT }
  end

  has_secure_password

  before_save { self.email = email.downcase }
end
