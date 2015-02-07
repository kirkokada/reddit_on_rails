# Users
puts("-- Populating Users...")

User.create!(name:  "Example User",
             email: "example@user.com",
             password:              "password",
             password_confirmation: "password")

30.times do |n|
  name  = Faker::Internet.user_name
  email = "example-#{n+1}@redditonrails.com"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end

puts("-- Populating Subreddits...")

# Subreddits

5.times do |n|
	name = Faker::Internet.domain_word
	user = User.find(n+1)
	description = Faker::Company.bs
	user.subreddits.create(name: name, description: description)
end

# Links

puts("-- Populating Links...")

10.times do
	users = User.order(:created_at).take(5)
	subreddits = Subreddit.all
	subreddits.each do |subreddit|
		users.each do |user|
			user.links.create(subreddit_id: subreddit.id, 
				                title: Faker::Company.catch_phrase, 
				                description: Faker::Company.bs, 
				                url: Faker::Internet.domain_name)
		end
	end
end

# Comments and Replies

puts("-- Populating comments and replyies...")

5.times do
	users = User.all.take(5)
	links = Link.all.take(5)
	links.each do |link|
		users.each do |user|
			user.comments.create(link_id: link.id,
				                   content: Faker::Hacker.say_something_smart)
		end
	end
end

Comment.all.each do |comment|
	User.all.take(3) do |user|
		user.comments.create(parent_id: comment.id,
			                   link_id:   comment.link.id,
			                   content:   Faker::Hacker.say_something_smart)
	end
end

# Subscriptions

puts("-- Populating subscriptions...")

users = User.all
subreddits = Subreddit.all
users.each do |user|
	subreddits.each do |subreddit|
		user.subscribe(subreddit)
	end
end

puts("Seeding complete!")