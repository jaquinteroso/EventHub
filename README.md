# EventHub

**Universidad de los Andes — Faculty of Engineering and Applied Sciences**  
**Course:** Web Technologies (202610)  
**Assignment 1:** User Stories, Data Model, and Landing Page

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

## Repository Structure

```
EventHub/
├── app/
│   └── views/
│       └── pages/
│           └── home.html.erb       # Landing page (Bootstrap)
├── relational_diagram.png          # Relational data model diagram
├── user_stories.md                 # Complete set of user stories
└── README.md                       # This file
```

---

## Deliverables

### 1. Landing Page (`app/views/pages/home.html.erb`)
Static HTML page styled with Bootstrap, including:
- Navbar with links to the main sections (Events, Categories, Login, Sign Up)
- Hero section introducing EventHub with a call-to-action button ("Browse Events")
- About section explaining the platform and its target users
- Contact section with placeholder contact information
- Footer with team name, course, and year

### 2. User Stories (`user_stories.md`)
Complete set of user stories following the standard format:
> *As a [type of user], I want to [do something], so that [reason/benefit].*

Covers event creation and management, event discovery and browsing, registration and waiting list behavior, reviews and ratings, and administrative moderation actions.

### 3. Data Model (`relational_diagram.png`)
Relational diagram including all entities, attributes, data types, primary and foreign keys, and relationships with cardinality notation.

---

## Tech Stack

- **Ruby on Rails 8** — main framework (MVC)
- **PostgreSQL** — database engine
- **Bootstrap** — styling and responsive design
- **Devise** — authentication
- **CanCanCan** — role-based authorization
- **ActionText** — rich text event descriptions

---

*Assignment 1 — April 2026*
