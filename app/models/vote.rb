class Vote < ActiveRecord::Base
	belongs_to :link
	belongs_to :user

	validates :link_id, uniqueness: { scope: :user }, 
									 presence: true
	validates :user_id, uniqueness: { scope: :link }, 
	                 presence: true
	validates :value, numericality: { greater_than_or_equal_to: -1,
	                                  less_than_or_equal_to:    1,
	                                  only_integer: true },
	                  presence: true

	after_save :update_link_score

	def up
		self.update_attribute(:value, 1)
	end

	def down
		self.update_attribute(:value, -1)
	end

	def neutral
		self.update_attribute(:value, 0)
	end

	private

		def update_link_score
			self.link.update_score
		end
end
