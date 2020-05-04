# Schmeddit

**Description: **A Reddit clone featuring:
- User accounts
- Posts
- Comments on posts
- Replies
- Upvotes on comments and posts
- Ability for user to save post to favorites
- Categories (sub-reddit like)

**Advanced features:**
- Nested replies to replies
- Handle multimedia in posts
- Users friending eachother
- Email updates
- Messaging between users

### User Stories
- User should be able to create account
	- Enter name, email, optionally upload profile picture
	- Create password with confirmation (use bcrypt to salt and hash)
	- Select favorite categories
- Index page should show list of categories with N number of posts from that categor
- User's home (show?) page should show their favorited posts and top posts from favorite categories
- User should be able to login and out
- Logged in users should be able to create post in category and create new category if not exists
- Users should be able to see a post, favorite, upvote and comment on post
- Users should see comments on post and upvote and be able to reply to comments
- Users should see replies to comments and upvote
- Users should be able to edit or delete their own posts
- Users should be able to edit or delete their own accounts 
- Users should be able to remove a post from favorites and edit favorite categores

### Models
**Primary:** *User, Post, Comment, Category*
**Join Tables:** *Reply, UserFavoritePost, UserFavoriteCategory, UserPostVote, UserCommentVote

#### User
- **Associations**
	- Has Many: *user_favorite_posts, user_favorite_categories, user_post_votes, user_comment_votes
	- Has many posts
	- has many comments
	- has many categories, through posts
- **Attributes**
	- username
	- fistname
	- lastname
	- profile img url
	- email
	- password
	- password_digest
	- Bio
#### Post
- **Associations**
	- Belongs to user
	- belongs_to category
	- has many comments
	- have many users, through comment, through user_post_votes, through user_post_favorites	
- **Attributes**
	- category_id
	- user_id
	- timestamps
	- title
	- content
#### Comment
- **Associations**
	- belongs to user
	- belongs to post
	- Has many replies
	- Has many users through user_comment_votes
- **Attributes**
	- user_id
	- post_id
	- content

#### Category
- **Associations**
	- Has many posts
	- Has many user_favorite_categories
	- Has many users, through user_favorite_categories
- **Attributes**
	- name
	- user_created_id

#### Reply
- **Associations**
	- belongs_to :parent, :class_name => 'Comment'
	- has_many :children, :class_name => 'Comment', :foreign_key => 'parent_id'
	- belongs_to user, through parent
	- has many users, through chilren

#### UserFavoritePost, User Post Vote
- **Associations**
	- belongs to user
	- belongs to post

#### UserFavoriteCategory
- **Associations**
	- belongs to user
	- belongs to category
	- has many posts, through category

#### UserCommentVotess
- **Associations**
	- belongs to user
	- belongs to comment
- **Attributes**
	- up?
