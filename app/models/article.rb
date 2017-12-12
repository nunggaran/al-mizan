# == Schema Information
#
# Table name: articles
#
#  id         :integer          not null, primary key
#  title      :string
#  content    :text
#  slug       :string
#  user_id    :integer
#  image      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Article < ApplicationRecord
	#validation
	validates :title, :content, :image, presence: true
	validates :title, uniqueness: true
	#on to many assocation
	belongs_to :user

	#use friendly id
	extend FriendlyId
	friendly_id :title, use: :slugged

	mount_uploader :image, ArticleUploader


	def posted_on
    created_at.strftime("#{created_at.day.ordinalize} %b %Y at %H:%M")
  end
  
end
