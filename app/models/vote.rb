class Vote < ActiveRecord::Base
	belongs_to :link
	belongs_to :user

	validates :link, uniqueness: { scope: :user }
	validates :user, uniqueness: { scope: :link }
	validates :value, numericality: { greater_than_or_equal_to: -1,
	                                  less_than_or_equal_to:    1,
	                                  only_integer: true }
end
