# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default("")
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  slug                   :string
#  first_name             :string
#  last_name              :string
#  address                :string
#  job                    :string
#  alumni                 :string
#  university             :string
#  faculty                :string
#  handphone              :string
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  username               :string
#  date_of_birth          :date
#  invitation_token       :string
#  invitation_created_at  :datetime
#  invitation_sent_at     :datetime
#  invitation_accepted_at :datetime
#  invitation_limit       :integer
#  invited_by_id          :integer
#  invited_by_type        :string
#  role                   :string           default("alumni")
#  year_of_entry          :string
#  year_graduated         :string
#  fb                     :string
#  ig                     :string
#  twitter                :string
#  avatar                 :string
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  VALID_EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true, 
				length: { minimum: 4, maximum: 45 },
				format: { with: VALID_EMAIL_REGEX }
  has_many  :articles, dependent: :destroy
  validates :first_name, :last_name, :year_of_entry, :year_graduated, presence: true
  validates :address, presence: true, length: { maximum: 100, minimum: 40 }
  validates :username, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 4, maximum: 20 },format: { without: /\s/ }
  devise :invitable, :database_authenticatable, :registerable,
       	:recoverable, :rememberable, :validatable, :confirmable, :trackable, :invite_for => 2.weeks

  has_one :testimony, dependent: :destroy

  scope :alumni, -> { where(role: "alumni")}
  scope :alumni_order, ->(page) { order('year_graduated, first_name').paginate(page: page, :per_page => 20) }
  scope :confirmed, -> {where("confirmed_at IS NOT NULL")}
  is_impressionable
  extend FriendlyId
  friendly_id :username, use: :slugged
  mount_uploader :avatar, AvatarUploader


  ROLES = ["alumni", "admin", "writer"]

  User::ROLES.each do |role|
    define_method("is_#{role}?".to_s) do
      self.role.eql?(role)
    end
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
