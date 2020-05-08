UserCommentVote.destroy_all
UserFavoriteCategory.destroy_all
UserFavoritePost.destroy_all
UserPostVote.destroy_all
Comment.destroy_all
Post.destroy_all
Category.destroy_all
User.destroy_all

# Make some users

25.times do
  name = Faker::Internet.username
  set = ['','?set=set2', '?set=set4']
  User.create(
    username: name,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.safe_email,
    profile_img_url: "https://robohash.org/#{name}#{set[rand(0..2)]}",
    bio: Faker::Lorem.paragraph(sentence_count: 2),
    password: Faker::Internet.password
  )
end

# Make some categories

10.times do
  Category.create(
    name: Faker::Hacker.adjective.titlecase,
  )
end

# Make some posts

Category.all.each do |c|
  25.times do
    Post.create(
      category_id: c.id,
      user_id: User.all.sample.id,
      title: Faker::Hacker.ingverb + ' ' + Faker::Hacker.noun + ' ' + Faker::Hacker.verb.titlecase,
      content: Faker::Lorem.paragraph_by_chars(number: rand(100..1000)),
      score: rand(0..100),
      num_favorites: rand(0..50)
      )
  end
end

# Make some comments

Post.all.each do |p|
  5.times do
    Comment.create(
      parent_id: p.id,
      parent_type: "Post",
      user_id: User.all.sample.id,
      content: Faker::Lorem.paragraph(sentence_count: 4),
      score: rand(0..100)
    )
  end
end

#Make some replies
Comment.all.each do |c|
  Comment.create(
    parent_id: c.id,
    parent_type: "Comment",
    user_id: User.all.sample.id,
    content: Faker::Lorem.paragraph(sentence_count: 4)
  )
end

400.times do
  Comment.create(
    parent_id: Comment.all.sample.id,
    parent_type: "Comment",
    user_id: User.all.sample.id,
    content: Faker::Lorem.paragraph(sentence_count: 4),
    score: rand(1..100)
  )
end 


