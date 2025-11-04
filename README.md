# Solid Queue Rails 8 Demo

## Overview

This Rails 8.1 demo app is a modern, real-time task manager that demonstrates:

- **Background job processing** with [Solid Queue](https://github.com/rails/solid_queue)
- **Live UI updates** using Turbo Streams (no page refresh needed)
- **Multiple database setup** (primary, queue, cache, cable)
- **Tailwind CSS** for a clean, responsive interface

## Features

- Add tasks with a form
- See tasks update live as jobs complete (status changes from `pending` to `done` automatically)
- Pagination for large task lists
- Error handling and user-friendly feedback
- Real background job processing with Solid Queue

## How it Works

1. **Create a task:** Submitting the form creates a new task with status `pending`.
2. **Job enqueued:** An ActiveJob (`TaskJob`) is enqueued via Solid Queue.
3. **Job processing:** The Solid Queue worker picks up the job, waits 2 seconds, and updates the task status to `done`.
4. **Live update:** Turbo Streams broadcasts the change, and the UI updates the task status in real time—no refresh needed.

## Setup Instructions

### Prerequisites

- Ruby 3.3+
- PostgreSQL (or update `config/database.yml` for your DB)
- Node.js & Yarn (for JS/CSS assets)

### Install dependencies

```sh
bundle install
yarn install
```

### Set up the database

```sh
bin/rails db:setup
# or, if already migrated:
bin/rails db:migrate
```

### Start the app (all processes)

```sh
bin/dev
```

This runs Rails, asset builder, and the Solid Queue worker together.

### Try it out

1. Open [http://localhost:3000](http://localhost:3000)
2. Add a new task
3. The task appears as `pending`, then updates to `done` after a few seconds—**without refreshing**

## Real-Time Updates: How Turbo Streams Work

- The view subscribes to Turbo Streams: `<%= turbo_stream_from "tasks" %>`
- The `Task` model uses `broadcasts_to ->(task) { "tasks" }` for automatic broadcasting
- When a task is updated, Turbo Streams sends a `replace` action to the browser, updating the row in place

## Solid Queue & Multiple Databases

- `config/database.yml` is set up for primary, queue, cache, and cable databases
- `config/queue.yml` and `config/cable.yml` are configured for Solid Queue and Solid Cable
- In development, **do not use the async cable adapter**—use `solid_cable` so background jobs can broadcast to the browser

## Troubleshooting

- If you see status not updating live, check that `config/cable.yml` uses `solid_cable` in development
- Make sure both the Rails server and the Solid Queue worker are running (via `bin/dev`)
- If assets don't load, run `yarn install`
- For database errors, check PostgreSQL is running and your config is correct
- For any errors, check the terminal output for helpful messages

## Customization

- Change job logic in `app/jobs/task_job.rb`
- Style the UI in `app/views/tasks/index.html.erb` and Tailwind CSS files

## Resources

- [Solid Queue documentation](https://github.com/rails/solid_queue)
- [Rails Getting Started Guide](https://guides.rubyonrails.org/getting_started.html)

---

Happy coding!
