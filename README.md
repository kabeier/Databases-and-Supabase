# Databases and Supabase

Two ~45-minute lectures for Code Platoon Phase III, Building Applications → Relational Databases & Supabase. Live site: https://kabeier.github.io/Databases-and-Supabase/

Each deck is a single HTML file. Open it, press **P** for presenter notes in a second window, **T** to start the lecture clock, **O** for the slide overview, **F** for fullscreen.

## Lecture 1: Relational Databases (~42 min, 19 slides)

| ~min | Segment |
|---|---|
| 0–3 | Open: live, add a task in Ticked, refresh, it's gone |
| 3–9 | What an RDBMS is: the library, table anatomy, SQL |
| 9–12 | Stories → tables, table or column? |
| 12–18 | Activity: Noun Hunt (Recipe Box) |
| 18–23 | Data types, quick-fire in chat |
| 23–29 | Live: draw projects and tasks in DrawSQL |
| 29–32 | Relationships: 1:1, M:1, M:M, how to choose |
| 32–36 | Activity: Relationship Sorter |
| 36–39 | Live: draw the foreign keys, add tags + task_tags, screenshot |
| 39–42 | Wrap up and homework |

## Lecture 2: Databases on the Cloud (~42 min, 20 slides)

| ~min | Segment |
|---|---|
| 0–3 | Open: the diagram from Lecture 1 |
| 3–7 | PostgreSQL, Supabase, why Supabase |
| 7–11 | Live: create the project, tour the dashboard |
| 11–16 | Live: Supabase MCP (project scope, in Ticked's folder), postgresql-table-design skill |
| 16–18 | The three inputs and the prompt |
| 18–24 | Live: paste the prompt + Activity: Approve or Push Back? |
| 24–31 | Live: review schema.sql, build one table at a time, verify |
| 31–38 | Live: explore the database in Supabase; front-end ✓ + database ✓, but no API yet (future lecture) |
| 38–42 | Guardrails + Supabase sub-agent, homework |

## Folder map

- `index.html`: the class landing page, with homework setup steps
- `lecture-1-relational-databases/`: slides, Noun Hunt, Relationship Sorter
- `lecture-2-databases-on-the-cloud/`: slides, Approve or Push Back
- `demo-kit/`: everything for the live demos. `RUNBOOK.md` lists every file, the night-before steps and the in-class table. Highlights:
  - `app_outline/` + `app-prompt.md`: Ticked's spec, laid out like Liftlog's
  - `backup-task-manager/`: Ticked as the SPA lectures left it (app + app_outline + CLAUDE.md + skills + front-end agent). Built to `task-manager/` on the site
  - `prompt.md`, `schema.sql`, the ERD screenshot, `setup-db-skill.sh`, `.claude/agents/`
- `task-manager/`: the built Ticked app served by GitHub Pages (`404.html` sends deep links back to it)
- `diagrams/`: tldraw diagrams (`.png` + editable `.tldr`), plus the DrawSQL screenshot
- `shared/`: the slide engine (same as SPAs and Claude)

## Notes on choices

- **The running example is Ticked, a task manager**, presented as the app from the SPA lectures in place of Liftlog. Its database has five tables: users, projects, tasks, tags and task_tags. All the app's data code is in one file (`src/data/db.js`).
- **The app and the database are not connected in these lectures.** Connecting them through an API is a future lecture. The slides say so clearly.
- **Aligned with the next lectures:**
  - **Users table:** the full-stack lecture's Postman exercise uses `/users` and `/tasks`. The authentication lecture rebuilds `users` around Supabase logins, with rules on `user_id`.
  - **Folders:** the app is `ticked/` (as students made it in the SPA lectures), and the database work lives in `ticked/supabase/`. The full-stack lecture's reading shows the app in a `front-end/` folder next to `supabase/`, so that move happens then.
  - **RLS:** see `demo-kit/RUNBOOK.md` → "Heads-up for the next lectures".
- **No users table yet.** There are no logins, so everyone shares the data. Accounts and "only your own tasks" rules come in a future lecture.
- **RLS:** `schema.sql` turns Row Level Security on (Supabase's advice). The rules come in future lectures; the dashboard can still see everything.
- **The Noun Hunt uses a different app (Recipe Box)**, so students practice the method instead of copying the live demo.
- **DrawSQL's free plan can't export** SQL or images (File → Export is locked; pricing lists export as paid). So students screenshot the diagram, Claude writes `schema.sql` from it, and they review that file before anything runs. That review is an extra pause-and-verify gate.
- **The Supabase MCP uses `--scope project`**, the command from the dashboard's Connect menu, because it's tied to one database. Context7 stays `--scope user` from the SPA lecture.

## Rebuild the site copy of Ticked

```bash
cd demo-kit/backup-task-manager && npm install
BASE=/Databases-and-Supabase/task-manager/ npm run build
rm -rf ../../task-manager && cp -r dist ../../task-manager
```

## Before you teach

- [ ] Follow `demo-kit/RUNBOOK.md`: dry run, then reset (delete the dry-run project, so you have a free project slot)
- [ ] Teacher guide and answer keys: `/mnt/storage/CP/Cohorts/eagle/Notes/`
