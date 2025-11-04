
# Solid Queue Rails 8 Demo

This is a beginner-friendly demo Rails 8.1 application using [Solid Queue](https://github.com/rails/solid_queue) for background job processing.

## Features

- Simple `Task` model with a name and status
- Homepage form to create tasks and enqueue jobs
- Background job (`TaskJob`) updates the task status after a short delay
- Modern UI with Tailwind CSS

---

## Getting Started

### 1. Prerequisites

- Ruby 3.3+ (check with `ruby -v`)
- PostgreSQL (or update `config/database.yml` for your DB)
- Node.js & Yarn (for JS/CSS assets)

### 2. Install dependencies

```
bundle install
yarn install
```

### 3. Set up the database

```
bin/rails db:setup
```
If you already ran migrations, you can use:
```
bin/rails db:migrate
```

### 4. Start the development server

```
bin/dev
```
This runs Rails, asset builder, and job processor together.

### 5. Try the Solid Queue demo

1. Open [http://localhost:3000](http://localhost:3000) in your browser.
2. Use the form to add a new task (enter a name and submit).
3. The new task appears in the list with status `pending`.
4. After a few seconds, the background job runs and updates the status to `done`.
5. Refresh the page to see the updated status.

---

## How it works (for beginners)

1. **You submit a task** using the form. This creates a new record in the database with status `pending`.
2. **A background job is enqueued** using Solid Queue. This means the work will be done in the background, not immediately.
3. **Solid Queue picks up the job** and runs the `TaskJob` class, which waits 2 seconds and then updates the task status to `done`.
4. **You see the result** by refreshing the page: the status changes from `pending` to `done`.

---

## Customization

- You can change the job logic in `app/jobs/task_job.rb`.
- You can style the UI further in `app/views/tasks/index.html.erb`.

---

## Troubleshooting

- If you get a database error, check that PostgreSQL is running and your `config/database.yml` is correct.
- If assets don't load, make sure you ran `yarn install` and are using `bin/dev`.
- For any errors, check the terminal output for helpful messages.

---

## More resources

- [Solid Queue documentation](https://github.com/rails/solid_queue)
- [Rails Getting Started Guide](https://guides.rubyonrails.org/getting_started.html)

---

Happy coding!
