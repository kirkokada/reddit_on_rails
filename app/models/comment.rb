class Comment < ActiveRecord::Base
	belongs_to :user
	belongs_to :link

	belongs_to :parent, class_name: "Comment"
	has_many :children, class_name: "Comment",
	                    foreign_key: "parent_id"

	validates :content, presence: true
	validates :user_id, presence: true
	validates :link_id, presence: true
end
