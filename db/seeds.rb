puts "Clearing database..."
Review.destroy_all
Registration.destroy_all
Event.destroy_all
Venue.destroy_all
Category.destroy_all
User.destroy_all

puts "Creating Users..."
admin = User.create!(full_name: "Admin User", email: "admin@uandes.cl", password: "password123", password_confirmation: "password123", role: :admin)
user1 = User.create!(full_name: "John Doe", email: "john@uandes.cl", password: "password123", password_confirmation: "password123", role: :regular)
user2 = User.create!(full_name: "Jane Smith", email: "jane@uandes.cl", password: "password123", password_confirmation: "password123", role: :regular)

puts "Creating Categories..."
sports = Category.create!(name: "Sports", description: "Athletic and physical activities.")
tech = Category.create!(name: "Technology", description: "Tech talks, hackathons, and workshops.")
study = Category.create!(name: "Study Groups", description: "Collaborative study sessions.")

puts "Creating Venues..."
gym = Venue.create!(name: "Campus Gym", address: "Building A, Floor 1", capacity_max: 50)
auditorium = Venue.create!(name: "Main Auditorium", address: "Building B, Floor 2", capacity_max: 200)
library_room = Venue.create!(name: "Library Study Room 4", address: "Library, Floor 3", capacity_max: 10)

puts "Creating Events..."
event_tech = Event.create!(
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

event_sports = Event.create!(
  title: "5v5 Soccer Tournament",
  description: "Friendly tournament for computer science students. <i>Bring your own cleats!</i>",
  start_date: 1.week.from_now,
  end_date: 1.week.from_now + 4.hours,
  max_capacity: 20,
  state: :published,
  organizer: user1,
  category: sports,
  venue: gym
)

event_past = Event.create!(
  title: "Advanced Git Workshop",
  description: "Deep dive into Git workflows.",
  start_date: 1.month.ago,
  end_date: 1.month.ago + 2.hours,
  max_capacity: 10,
  state: :published,
  organizer: admin,
  category: tech,
  venue: library_room
)

puts "Creating Registrations..."
Registration.create!(user: user1, event: event_tech, status: :confirmed)
Registration.create!(user: user2, event: event_tech, status: :confirmed)
Registration.create!(user: user2, event: event_sports, status: :waiting_list)
Registration.create!(user: user1, event: event_past, status: :confirmed) 

puts "Completing past events..."
event_past.update!(state: :completed) 

puts "Creating Reviews..."
Review.create!(user: user1, event: event_past, rating: 5, comment: "Excellent workshop, highly recommended!") # 4. Pasa la validación

puts "Seed finished successfully!"
