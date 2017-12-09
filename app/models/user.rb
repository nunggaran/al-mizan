class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  devise :invitable, :database_authenticatable, :registerable,
       	:recoverable, :rememberable, :validatable, :confirmable, :trackable, :invite_for => 2.weeks
end
