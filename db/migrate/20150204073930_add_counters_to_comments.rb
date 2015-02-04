class AddCountersToComments < ActiveRecord::Migration
  def change
    add_column :comments, :parents_count, :integer, default: 0
    add_column :comments, :children_count, :integer, default: 0
    Comment.reset_column_information
    Comment.all.each do |comment|
    	comment.update_attribute :children_count, comment.children.count
    	if p = comment.parent
    		n = 1
    		n += 1 while p = p.parent
	    	comment.update_attribute :parents_count, n
    	end
    end
  end
end
