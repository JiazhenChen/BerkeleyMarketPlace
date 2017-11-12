# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

if Rails.env !=  "production"
    DatabaseCleaner.clean_with(:truncation)
end


def generate_user_posts user
    
    item_posts = [
        {
            title: "iClicker for sale", category: "item", subcategory: "electronics", price: 10,
            available: true, release_time: random_past_time, description: "Used iclicker, model 1, only 10 dollars, contact me for more info.",
            image: test_image("db/support/testImage/student-iclicker.png")
        },
        # {
        #     title: "Math 1A textbook", category: "item", subcategory: "book", price: 20,
        #     available: true, release_time: random_past_time, 
        # },
        # {
        #     title: "Linear Algebra Solution Manual", category: "item", subcategory: "book", price: 15,
        #     available: false, release_time: random_past_time, 
        # },
        # {
        #     title: "Old guitar, used for 1 years", category: "item", subcategory: "music related", price: 200,
        #     available: true, release_time: random_past_time,
        # },
        # {
        #     title: "XBOX with 20 games bundle, just $233.3" % user.id, category: "item", subcategory: "electronics", price: 233.3,
        #     available: true, release_time: random_past_time,
        # },
        # {
        #     title: "PS with 2 games bundle, just $200" % user.id, category: "item", subcategory: "electronics", price: 200,
        #     available: true, release_time: random_past_time,
        # },
        # {
        #     title: "" % user.id, category: "item", subcategory: "electronics", price: 2333.3,
        #     available: true, release_time: random_past_time,
        # },
        # {
        #     title: "Used IKEA Kingbed" % user.id, category: "item", subcategory: "furniture", price: 233.3,
        #     available: true, release_time: random_past_time, 
        # },
    ]

    job_posts = [
        # {
        #     title: "%d machine learning expert needed" % user.id, category: "job", subcategory: "computer science", price: 233.3,
        #     available: true, release_time: random_past_time, 
        # },
        # {
        #     title: "%d workers for house-moving, 20$/hour" % user.id, category: "job", subcategory: "daily life", price: 233.3,
        #     available: true, release_time: random_past_time, 
        # },
        # {
        #     title: "Short-term %d Math tutor" % user.id, category: "job", subcategory: "math", price: 233.3,
        #     available: false, release_time: random_past_time, 
        # },
        # {
        #     title: "%d pianoists for performance" % user.id, category: "job", subcategory: "performance", price: 233.3,
        #     available: true, release_time: random_past_time,
        # },
        # {
        #     title: "Help me eat chicken in PUBG for %d times! Highly rewarded!!" % user.id, category: "job", subcategory: "daily life", price: 233.3,
        #     available: true, release_time: random_past_time,
        # },
        # {
        #     title: "Beg %d workers to clean the bathroom for $233.3/h" % user.id, category: "job", subcategory: "daily life", price: 233.3,
        #     available: true, release_time: random_past_time, 
        # },
        # {
        #     title: "Taking notes for CS188 and CS189 for %d years" % user.id, category: "job", subcategory: "computer science", price: 233.3,
        #     available: true, release_time: random_past_time, 
        # },
        
    ]
    
    event_posts = [
        # {
        #     title: "%d Concert tickets in SF" % user.id, category: "event", subcategory: "performance", price: 233.3,
        #     available: true, release_time: random_past_time, 
        # },
        # {
        #     title: "%d Berkeley VS Stanford tickets" % user.id, category: "event", subcategory: "sports", price: 233.3,
        #     available: true, release_time: random_past_time, 
        # },
        # {
        #     title: "%d hour Asian life matters speech in Sproul" % user.id, category: "event", subcategory: "speech", price: 233.3,
        #     available: false, release_time: random_past_time, 
        # },
        # {
        #     title: "Private dinner with %d Google executive board" % user.id, category: "event", subcategory: "info session", price: 233.3,
        #     available: true, release_time: random_past_time,
        # },
        # {
        #     title: "Berkeley MarketPlace NO.%d Info Session" % user.id, category: "event", subcategory: "info session", price: 233.3,
        #     available: true, release_time: random_past_time, 
        # },
        # {
        #     title: "Make Berkeley Great For %d Times, public speech in People's Park" % user.id, category: "event", subcategory: "speech", price: 233.3,
        #     available: true, release_time: random_past_time, 
        # },
        # {
        #     title: "Date me on Valentine's day %d years later, 233.3/h rate" % user.id, category: "event", subcategory: "daily life", price: 233.3,
        #     available: true, release_time: random_past_time, 
        # },
    ]
    
    posts = (item_posts + event_posts + job_posts)
    
    for post_info in posts do
        #post_info[:image] = random_image
        post_info[:author_id] = user.id
        #post_info[:description] = 20.sentences.join(" ")
        Post.create!(post_info)
    end
    
end

def generate_seed_user uid
    user_info = { uid: uid, email: "seed-user%d@berkeley.edu" % uid, name: "Seed User%d" % uid  }
    User.create!(user_info)
end

def random_past_time
    rand(5).day.ago - rand(24).hour
end

def future_time
    Time.now + 2000.days
end

def random_image
    image_path_list = Dir[File.join(Rails.root, "db/support/*")]
    File.open(image_path_list.sample)
end

def test_image path
    image_patt = Dir[File.join(Rails.root, path)]
    File.open(image_path)
end

if Rails.env != "production"
    uid_list = [1]
else
    uid_list = 1..5
end
    
for uid in uid_list do
    user = generate_seed_user uid
    generate_user_posts user
end
    
# add a user that uploaded nothing, with id 
empty_user = { email: "empty@berkeley.edu", name: "empty user" }
User.create!(empty_user)