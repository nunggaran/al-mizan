class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  validates :username, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 4, maximum: 20 },format: { without: /\s/ }
  devise :invitable, :database_authenticatable, :registerable,
       	:recoverable, :rememberable, :validatable, :confirmable, :trackable, :invite_for => 2.weeks
end
