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
  validates :email, presence: true, uniqueness: true, length: { minimum: 4, maximum: 45 }, format: { with: VALID_EMAIL_REGEX }
  has_many  :articles, dependent: :destroy
  validates :first_name, :last_name, presence: true
  
  validates :username, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 4, maximum: 30 },format: { without: /\s/ }

  # devise  :invitable, :database_authenticatable, :registerable,
  #      	  :recoverable, :rememberable, :validatable, :confirmable, :trackable, :invite_for => 2.weeks,
  #         :omniauthable, :omniauth_providers => [:facebook]

  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable, :confirmable, :invitable, :trackable,
        :omniauthable, :omniauth_providers => [:facebook, :twitter]

  has_one :testimony, dependent: :destroy

  scope :alumni, -> { where(role: "alumni")}
  scope :alumni_order, ->(page) { order('year_graduated, first_name').paginate(page: page, :per_page => 30) }
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

  def self.from_omniauth(auth)
    data = auth.info
    user = where(provider: auth.provider, uid: auth.uid, email: auth.info.email).first

    unless user.present?
      # asasas
      user                       = new
      user.email                 = auth.info.email
      password = Devise.friendly_token[0,10]
      user.password              = password
      user.password_confirmation = password
      Rails.logger.info("============ Profile password = #{user.password}")
      user.first_name            = auth.info.first_name   # assuming the user model has a name
      user.last_name             = auth.info.last_name
      avatar_tmp                 = auth.info.image
      user.remote_avatar_url     = avatar_tmp + "?type=large" # assuming the user model has an image
      user.username              = auth.info.name.to_s.split(" ")[0].downcase + "_" + auth.info.name.to_s.split(" ")[1].downcase + rand(1..100).to_s
      Rails.logger.info("============ Profile username = #{user.username}")
      user.provider              = auth.provider
      user.uid                   = auth.uid
      Rails.logger.info("============ Profile avatar from fb = #{auth.info.image}")
      Rails.logger.info("============ Profile avatar = #{user.remote_avatar_url}")
      Rails.logger.info("========= Error from login facebook = #{user.errors.full_messages if user.errors.present?} ")
      if user.errors.any?
        Rails.logger.info("========= Error from login facebook = #{user.errors.full_messages} ")
      end
      user.skip_confirmation!

      user.save!
    end

    user

  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

end
