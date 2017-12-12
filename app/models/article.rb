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

end
