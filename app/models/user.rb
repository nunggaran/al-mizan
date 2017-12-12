class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  VALID_EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true, 
				length: { minimum: 4, maximum: 45 },
				format: { with: VALID_EMAIL_REGEX }
  has_many  :articles
  validates :first_name, :last_name, presence: true
  # validates :username, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 4, maximum: 20 },format: { without: /\s/ }
  devise :invitable, :database_authenticatable, :registerable,
       	:recoverable, :rememberable, :validatable, :confirmable, :trackable, :invite_for => 2.weeks
end
