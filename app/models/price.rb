# == Schema Information
#
# Table name: prices
#
#  id         :integer          not null, primary key
#  amount_idr :string
#  amount_usd :string
#  time       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Price < ApplicationRecord
end
