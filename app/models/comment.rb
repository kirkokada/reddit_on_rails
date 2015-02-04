class Comment < ActiveRecord::Base
	belongs_to :user
	belongs_to :link

	belongs_to :parent, class_name: "Comment",
	                    counter_cache: :children_count
	has_many :children, class_name: "Comment",
	                    foreign_key: "parent_id"

	validates :content, presence: true
	validates :user_id, presence: true
	validates :link_id, presence: true

	before_save :set_parents_count

	def parent?
		return true if children.present?
	end

	def child?
		return true if parent.present?
	end
	
	private

		def set_parents_count
			if p = self.parent
				n = 1
				n += 1 while p = p.parent
				self.parents_count = n
			end
		end
end
