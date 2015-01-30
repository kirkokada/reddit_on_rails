class Link < ActiveRecord::Base
	validates :title, presence: true
	validates :url, presence: true, format: URI::regexp(%w(http https))
	validates :user_id, presence: true
	before_validation :append_http

	belongs_to :user

	private
		# Appends 'http://' to the url if not present
		def append_http
			self.url = "http://#{self.url}" unless self.url[/\Ahttps?:\/\//] 
		end
end
