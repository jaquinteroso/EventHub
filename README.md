# EventHub

**Universidad de los Andes — Faculty of Engineering and Applied Sciences**
**Course:** Web Technologies (202610)
**Assignment 2:** Rails Application with Database Integration

---

## Team Members

| Name | GitHub |
|---|---|
| Jorge Quinteros | [@jaquinteroso](https://github.com/jaquinteroso) |
| Francisco Correa | [@C0RREAA](https://github.com/C0RREAA) |

---

## Project Description

**EventHub** is a web platform for the university community that allows users to create, discover, and join events such as talks, workshops, sports activities, social gatherings, and study groups. The system manages event registration with capacity limits and waiting lists, and allows participants to leave reviews after attending an event.

---

## Data Model

The application is built around the following entities:

- **User** — Authenticated user with a role (`regular` or `admin`). Can organize events, register for events, and leave reviews.
- **Event** — Created by a user (organizer), belongs to a category and venue. Has a lifecycle state: `draft`, `published`, `ongoing`, `completed`, or `cancelled`.
- **Category** — Groups events by type (e.g., talks, workshops, sports).
- **Venue** — Physical location for an event, with a maximum capacity.
- **Registration** — Join table between users and events. Status is either `confirmed` or `waiting_list`.
- **Review** — Left by a user for a completed event they attended. Includes a rating (1–5) and a comment.

---

## Setup Instructions

### Requirements

- Ruby 3.2.2
- Rails 8
- PostgreSQL
- Node.js & Yarn

### Installation

```bash
# Clone the repository
git clone https://github.com/jaquinteroso/EventHub.git
cd EventHub

# Install dependencies
bundle install
yarn install

# Set up the database
bin/rails db:create
bin/rails db:migrate
bin/rails db:seed

# Start the server
bin/rails server
```

Then open [http://localhost:3000](http://localhost:3000) in your browser.

---

## Repository Structure

```
EventHub/
├── app/
│   ├── controllers/
│   │   ├── categories_controller.rb
│   │   ├── events_controller.rb
│   │   ├── pages_controller.rb
│   │   └── venues_controller.rb
│   ├── models/
│   │   ├── category.rb
│   │   ├── event.rb
│   │   ├── registration.rb
│   │   ├── review.rb
│   │   ├── user.rb
│   │   └── venue.rb
│   └── views/
│       └── pages/
│           └── home.html.erb       # Landing page
├── db/
│   ├── schema.rb
│   └── seeds.rb                    # Sample data for all entities
├── relational_diagram.png          # Relational data model diagram
├── user_stories.md                 # Complete set of user stories
└── README.md                       # This file
```

---

## Tech Stack

- **Ruby on Rails 8** — main framework (MVC)
- **PostgreSQL** — database engine
- **Bootstrap** — styling and responsive design
- **Devise** — authentication
- **CanCanCan** — role-based authorization
- **ActionText** — rich text event descriptions

---

*Assignment 2 — May 2026*
