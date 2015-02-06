class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :links
  has_many :votes
  has_many :comments
  has_many :subreddits

  def front_page_links
  	Link.all
  end

  # Returns false if vote 
  def voted?(link)
  	vote = Vote.find_by(user: self, link: link)
  	!vote.nil?
  end

  # Creates vote in with the specified value or updates an existing vote
  def vote(link, value)
  	if vote = Vote.find_by(user: self, link: link)
  		vote.update_attribute(:value, value)
  	else
  		self.votes.create(link: link, value: value)
  	end
  end

  def unvote(link)
  	Vote.find_by(user: self, link: link).destroy
  end
end
