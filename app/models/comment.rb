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

	delegate :name, to: :user, prefix: true

	delegate :title, to: :link, prefix: true

	before_save :set_parents_count

	default_scope { order 'created_at DESC' }
	private

		def set_parents_count
			if p = self.parent
				n = 1
				n += 1 while p = p.parent
				self.parents_count = n
			end
		end
end
