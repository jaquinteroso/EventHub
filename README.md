# EventHub

**Universidad de los Andes — Faculty of Engineering and Applied Sciences**  
**Course:** Web Technologies (202610)  
**Assignment 4:** Authentication and Authorization

## Team Members

| Name | GitHub |
|---|---|
| Jorge Quinteros | [@jaquinteroso](https://github.com/jaquinteroso) |
| Francisco Correa | [@C0RREAA](https://github.com/C0RREAA) |

## Project Description

EventHub is a web platform for the university community to create, discover, register for, and review events such as talks, workshops, sports activities, social gatherings, and study groups. The system manages event capacity, waiting lists, event lifecycle states, and post-event reviews.

## Assignment 4 Features

- **Authentication with Devise:** users can sign up, log in, log out, reset passwords, and edit their profile.
- **Authorization with CanCanCan:** role-based access control for regular users and admins.
- **Role-based UI:** navigation and action buttons are shown only when the current user is allowed to use them.
- **Admin area:** admins can manage users and access moderation links for categories, venues, and recent reviews.
- **Ownership rules:** regular users can edit or cancel only their own events and cancel only their own registrations.
- **Public browsing:** guests can browse published events, view event details, and read reviews.

## Roles and Permissions

- **Guest:** can browse published events, categories, venues, and read reviews.
- **Regular user:** can create events, edit/cancel their own events, register for published events, cancel their own registrations, and review completed events they attended.
- **Admin:** can manage users, categories, venues, reviews, and any event.

## Data Model

- **User:** authenticated account with `full_name`, `email`, and role (`regular` or `admin`).
- **Event:** organized by a user, belongs to a category and venue, and has state (`draft`, `published`, `ongoing`, `completed`, or `cancelled`).
- **Category:** groups events by type.
- **Venue:** physical location with a maximum capacity.
- **Registration:** joins users and events with `confirmed` or `waiting_list` status.
- **Review:** rating and comment left by a user for a completed event they attended.

## Setup Instructions

### Requirements

- Ruby 3.2.2 or compatible local Ruby for Rails 8
- Rails 8
- PostgreSQL
- Node.js and Yarn

### Installation

```bash
bundle install
yarn install
bin/rails db:create
bin/rails db:migrate
bin/rails db:seed
bin/rails server
```

Open [http://localhost:3000](http://localhost:3000).

### Test Credentials

After running `bin/rails db:seed`, use:

- **Admin:** `admin@eventhub.com` / `password123`
- **Regular user:** `user@eventhub.com` / `password123`
- **Regular user:** `john@eventhub.com` / `password123`
- **Regular user:** `jane@eventhub.com` / `password123`

## Verification

```bash
bin/rails routes
bin/rails test
```

## Tech Stack

- Ruby on Rails 8
- PostgreSQL
- Bootstrap
- Devise
- CanCanCan
- ActionText
- Turbo and Stimulus
