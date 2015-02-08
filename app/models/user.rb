class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :links
  has_many :votes
  has_many :comments
  has_many :subreddits
  has_many :subscriptions, dependent: :destroy
  has_many :subscribed_subreddits, through: :subscriptions, source: :subreddit

  def front_page_links
    subreddit_ids = "SELECT subreddit_id FROM subscriptions 
                     WHERE user_id = :user_id"
    Link.where("subreddit_id IN (#{subreddit_ids})", user_id: id)
  end

  # Returns false if vote exists
  def voted?(link)
  	!self.votes.find_by(link: link).nil?
  end

  # Creates vote in with the specified value or updates an existing vote
  def vote(link, direction)
  	if vote = self.votes.find_by(link: link)
  		vote.send(direction)
  	else
  		vote = self.votes.create(link: link)
      vote.send(direction)
  	end
  end

  # Subscribe to a subreddit

  def subscribe(subreddit)
    subscriptions.create(subreddit: subreddit)
  end

  # Unsubscribe to a subreddit 

  def unsubscribe(subreddit)
    subscriptions.find_by(subreddit: subreddit).destroy
  end

  # Returns true if the user is subscribed to the subreddit

  def subscribed?(subreddit)
    subscribed_subreddits.include?(subreddit)
  end

  # Returns an array of links and comments

  def activity
    objects = links.take(15) + comments.take(15)
    objects = objects.sort_by(&:created_at).reverse
  end
end
