# Ticked (Task Manager)

A small task manager built with React, Vite and React Router: add tasks, group them into
projects, tag them, give them due dates, and tick them off. It was built from the specs in
[`app_outline/`](app_outline/) (user journey, style guide, wireframes and a user story per page).

There's no backend yet. The data lives in memory, so **refreshing the page resets everything**
to the seed data.

## Run it

```bash
npm install && npm run dev
```

## Where the data lives

Every read and write goes through **one file: [`src/data/db.js`](src/data/db.js)**. It keeps four
arrays shaped like the database tables (`projects`, `tasks`, `tags`, `task_tags`) and exports async
functions (`listTasks`, `createTask`, `deleteProject`, ...). To move to a real database (Supabase),
rewrite only that file; `src/context/TaskContext.jsx` and the pages stay the same.

## Pages

| Route | Page |
| --- | --- |
| `/` | Tasks: everything, filter by status and tag |
| `/tasks/new` | New Task (`?project=<id>` pre-picks a project) |
| `/projects` | Projects + new project form |
| `/projects/:id` | One project and its tasks |

Building for GitHub Pages in a sub-folder: `BASE=/Databases-and-Supabase/task-manager/ npm run build`.
