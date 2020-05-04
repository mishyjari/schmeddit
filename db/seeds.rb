UserCommentVote.destroy_all
UserFavoriteCategory.destroy_all
UserFavoritePost.destroy_all
UserPostVote.destroy_all
Reply.destroy_all
Comment.destroy_all
Post.destroy_all
Category.destroy_all
User.destroy_all

# Make some users

25.times do
  User.create(
    username: Faker::Internet.username,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.safe_email,
    profile_img_url: Faker::LoremFlickr.image(size: '200x300'),
    bio: Faker::Lorem.paragraph(sentence_count: 2),
    password: Faker::Internet.password
  )
end

# Make some categories

10.times do
  Category.create(
    name: Faker::Hacker.adjective,
  )
end

# Make some posts

Category.all.each do |c|
  25.times do
    Post.create(
      category_id: c.id,
      user_id: User.all.sample.id,
      title: Faker::Hacker.ingverb + ' ' + Faker::Hacker.noun + ' ' + Faker::Hacker.verb,
      content: 100.times do Faker::Hacker.say_something_smart + ' ' end
      )
  end
end

# Make some comments

Post.all.each do |p|
  5.times do
    Comment.create(
      post_id: p.id,
      user_id: User.all.sample.id,
      content: Faker::Lorem.paragraph(sentence_count: 4)
    )
  end
end

# Make some replies
Comment.all.each do |c|
  Reply.create(
    parent_id: c.id,
    child_id: Comment.all.sample.id,
  )
end

# Gives posts some user votes
Post.all.each do |p|
  25.times do
    UserPostVote.create(
      post_id: p.id,
      user_id: User.all.sample.id,
      up_vote?: Faker::Boolean.boolean(true_ratio: 0.8)
    )
  end
end

# Give users some favorited posts
User.all.each do |u|
  10.times do 
    UserFavoritePost.create(
      user_id: u.id,
      post_id: Post.all.sample.id
    )
  end
end

# Give users some favorite categories
User.all.each do |u|
  3.times do 
    UserFavoriteCategory.create(
      user_id: u.id,
      category_id: Category.all.sample.id
    )
  end
end

# Give the comments some votes
Comment.all.each do |c|
  20.times do
    UserCommentVote.create(
      comment_id: c.id,
      user_id: User.all.sample.id,
      up_vote?: Faker::Boolean.boolean(true_ratio: 0.8)
    )
  end
end

