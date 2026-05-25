# EventHub

**Universidad de los Andes — Faculty of Engineering and Applied Sciences**
**Course:** Web Technologies (202610)
**Assignment 3:** CRUD, Forms, Validations, and ActionText

---

## Team Members

| Name | GitHub |
|---|---|
| Jorge Quinteros | [@jaquinteroso](https://github.com/jaquinteroso) |
| Francisco Correa | [@C0RREAA](https://github.com/C0RREAA) |

---

## Assignment 3 Updates

* **Authentication:** Integrated Devise for user management, including customized views to support the `full_name` attribute.
* **Rich Text:** Configured ActionText for rich event descriptions, allowing organizers to format text with bold, italics, lists, and links.
* **CRUD Operations:** Full interactive CRUD functionality implemented for Events, Venues, and Categories with Bootstrap-styled forms.
* **Business Logic & Validations:** * Automatic waitlist promotion: If an event is full, users are waitlisted. If a confirmed user cancels, the next waitlisted user is automatically promoted.
  * Event state lifecycle: Events start as `draft`, can be `published` (to accept registrations), and then marked as `completed` or `cancelled`.
  * Restrictions: Users can only register for `published` events, and can only review `completed` events they attended.

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
git clone [https://github.com/jaquinteroso/EventHub.git](https://github.com/jaquinteroso/EventHub.git)
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

### Test Credentials
After running the seed file, you can log in using any of the following pre-configured accounts:

- **Admin User (Organizer):** `admin@uandes.cl` / `password123`
- **Regular User 1:** `john@uandes.cl` / `password123`
- **Regular User 2:** `jane@uandes.cl` / `password123`
---

## Repository Structure

```text
EventHub/
├── app/
│   ├── controllers/
│   │   ├── categories_controller.rb
│   │   ├── events_controller.rb
│   │   ├── pages_controller.rb
│   │   ├── registrations_controller.rb
│   │   ├── reviews_controller.rb
│   │   └── venues_controller.rb
│   ├── models/
│   │   ├── category.rb
│   │   ├── event.rb
│   │   ├── registration.rb
│   │   ├── review.rb
│   │   ├── user.rb
│   │   └── venue.rb
│   └── views/
│       ├── categories/       # CRUD views
│       ├── devise/           # Custom authentication views
│       ├── events/           # CRUD views & form partial
│       ├── pages/            # Landing page
│       ├── shared/           # Navbar and Footer partials
│       └── venues/           # CRUD views
├── db/
│   ├── schema.rb
│   └── seeds.rb              # Sample data showcasing waitlists and states
├── docs/                     # Updated data models and user stories
└── README.md                 # This file
```

---

## Tech Stack

- **Ruby on Rails 8** — main framework (MVC)
- **PostgreSQL** — database engine
- **Bootstrap** — styling, alerts, and responsive design
- **Devise** — authentication
- **ActionText** — rich text event descriptions

---

*Assignment 3 — May 25, 2026*
