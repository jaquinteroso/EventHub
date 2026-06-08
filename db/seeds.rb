PASSWORD = "password123"

def seed_user(email:, full_name:, role:)
  user = User.find_or_initialize_by(email: email)
  user.full_name = full_name
  user.role = role
  user.password = PASSWORD if user.new_record?
  user.password_confirmation = PASSWORD if user.new_record?
  user.save!
  user
end

def seed_category(name:, description:)
  category = Category.find_or_initialize_by(name: name)
  category.description = description
  category.save!
  category
end

def seed_venue(name:, address:, capacity_max:)
  venue = Venue.find_or_initialize_by(name: name)
  venue.address = address
  venue.capacity_max = capacity_max
  venue.save!
  venue
end

def seed_event(title:, organizer:, category:, venue:, description:, start_date:, end_date:, max_capacity:, state:)
  event = Event.find_or_initialize_by(title: title)
  event.assign_attributes(
    organizer: organizer,
    category: category,
    venue: venue,
    description: description,
    start_date: start_date,
    end_date: end_date,
    max_capacity: max_capacity,
    state: state
  )
  event.save!
  event
end

def seed_registration(user:, event:)
  Registration.find_or_create_by!(user: user, event: event)
end

def seed_review(user:, event:, rating:, comment:)
  review = Review.find_or_initialize_by(user: user, event: event)
  review.rating = rating
  review.comment = comment
  review.save!
  review
end

puts "Creating users..."
admin = seed_user(email: "admin@eventhub.com", full_name: "Admin User", role: :admin)
user = seed_user(email: "user@eventhub.com", full_name: "Regular User", role: :regular)
john = seed_user(email: "john@eventhub.com", full_name: "John Doe", role: :regular)
jane = seed_user(email: "jane@eventhub.com", full_name: "Jane Smith", role: :regular)

puts "Creating categories..."
sports = seed_category(name: "Sports", description: "Athletic and physical activities.")
tech = seed_category(name: "Technology", description: "Tech talks, hackathons, and workshops.")
study = seed_category(name: "Study Groups", description: "Collaborative study sessions.")

puts "Creating venues..."
gym = seed_venue(name: "Campus Gym", address: "Building A, Floor 1", capacity_max: 50)
auditorium = seed_venue(name: "Main Auditorium", address: "Building B, Floor 2", capacity_max: 200)
library_room = seed_venue(name: "Library Study Room 4", address: "Library, Floor 3", capacity_max: 10)

puts "Creating events..."
event_tech = seed_event(
  title: "Intro to Ruby on Rails",
  description: "Learn the basics of MVC with Rails 8. <b>Highly recommended!</b>",
  start_date: 2.days.from_now,
  end_date: 2.days.from_now + 2.hours,
  max_capacity: 100,
  state: :published,
  organizer: admin,
  category: tech,
  venue: auditorium
)

event_sports = seed_event(
  title: "5v5 Soccer Tournament",
  description: "Friendly tournament for computer science students. <i>Bring your own cleats!</i>",
  start_date: 1.week.from_now,
  end_date: 1.week.from_now + 4.hours,
  max_capacity: 20,
  state: :published,
  organizer: john,
  category: sports,
  venue: gym
)

event_study = seed_event(
  title: "Algorithms Study Group",
  description: "Small group review session before the algorithms midterm.",
  start_date: 3.days.from_now,
  end_date: 3.days.from_now + 90.minutes,
  max_capacity: 8,
  state: :draft,
  organizer: user,
  category: study,
  venue: library_room
)

event_past = seed_event(
  title: "Advanced Git Workshop",
  description: "Deep dive into Git workflows.",
  start_date: 1.month.ago,
  end_date: 1.month.ago + 2.hours,
  max_capacity: 10,
  state: :published,
  organizer: jane,
  category: tech,
  venue: library_room
)

puts "Creating registrations..."
seed_registration(user: user, event: event_tech)
seed_registration(user: john, event: event_tech)
seed_registration(user: jane, event: event_sports)
seed_registration(user: user, event: event_past)
seed_registration(user: john, event: event_past)

event_past.update!(state: :completed)

puts "Creating reviews..."
seed_review(user: user, event: event_past, rating: 5, comment: "Excellent workshop, highly recommended!")
seed_review(user: john, event: event_past, rating: 4, comment: "Clear explanations and useful examples.")

puts "Seed finished successfully!"
