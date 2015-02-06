class Subreddit < ActiveRecord::Base
	belongs_to :user
	has_many :links

	VALID_NAME_REGEX = /\A[\w]+\z/ 
	validates :name, presence: true, 
	                 uniqueness: { case_sensitive: false },
	                 format: { with: VALID_NAME_REGEX }
	validates :user_id, presence: true

	before_save :downcase_name

	delegate :name, to: :user, prefix: true

	def to_param
		name
	end

	private
	 def downcase_name
	 	 self.name.downcase!
	 end
end
