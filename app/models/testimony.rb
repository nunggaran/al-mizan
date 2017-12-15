# == Schema Information
#
# Table name: testimonies
#
#  id         :integer          not null, primary key
#  content    :string
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Testimony < ApplicationRecord
	belongs_to :user
	validates :content, presence: true, length: { maximum: 280, minimum: 150 }

end
