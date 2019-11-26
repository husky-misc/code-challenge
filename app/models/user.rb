# frozen_string_literal: true

class User < ActiveRecord::Base
  extend Devise::Models # added to avoid undefined method 'devise' for User error
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User
end
