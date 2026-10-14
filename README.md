# Databases and Supabase

Two ~45-minute lectures for Code Platoon Phase III, Building Applications → Relational Databases & Supabase. Live site: https://kabeier.github.io/Databases-and-Supabase/

Each deck is a single HTML file. Open it, press **P** for presenter notes in a second window, **T** to start the lecture clock, **O** for the slide overview, **F** for fullscreen.

## Lecture 1: Relational Databases (~42 min, 19 slides)

| ~min | Segment |
|---|---|
| 0–3 | Open: the browser forgets, a database remembers |
| 3–9 | What an RDBMS is: the library, table anatomy, SQL |
| 9–12 | Stories → tables, table or column? |
| 12–18 | Activity: Noun Hunt (Recipe Box) |
| 18–23 | Data types, quick-fire in chat |
| 23–29 | Live: draw users, projects, tasks in DrawSQL |
| 29–32 | Relationships: 1:1, M:1, M:M, how to choose |
| 32–36 | Activity: Relationship Sorter |
| 36–39 | Live: draw the foreign keys, add tags + task_tags, screenshot |
| 39–42 | Wrap up and homework |

## Lecture 2: Databases on the Cloud (~42 min, 19 slides)

| ~min | Segment |
|---|---|
| 0–3 | Open: yesterday's diagram |
| 3–9 | PostgreSQL, Supabase, why Supabase |
| 9–14 | Live: create the project, tour the dashboard |
| 14–20 | Live: Supabase MCP (project scope), postgresql-table-design skill |
| 20–22 | The three inputs and the prompt |
| 22–28 | Live: paste the prompt + Activity: Approve or Push Back? |
| 28–36 | Live: review schema.sql, build one table at a time, verify |
| 36–42 | Guardrails, Supabase sub-agent, homework |

## Folder map

- `index.html`: the class landing page, with homework setup steps
- `lecture-1-relational-databases/`: slides, Noun Hunt, Relationship Sorter
- `lecture-2-databases-on-the-cloud/`: slides, Approve or Push Back
- `demo-kit/`: user stories, prompt, backup `schema.sql`, the ERD screenshot, `setup-db-skill.sh`, `supabase-agent.md`, and `RUNBOOK.md` (night-before steps and the in-class table)
- `diagrams/`: tldraw diagrams (`.png` + editable `.tldr`), plus the DrawSQL screenshot
- `shared/`: the slide engine (same as SPAs and Claude)

## Notes on choices

- **The running example is the curriculum's task manager** (users, projects, tasks), plus tags so there's a many-to-many to draw.
- **The Noun Hunt uses a different app (Recipe Box)**, so students practice the method instead of copying the live demo.
- **DrawSQL's free plan can't export** SQL or images (File → Export is locked; pricing lists export as paid). So students screenshot the diagram, Claude writes `schema.sql` from it, and they review that file before anything runs. That review is an extra pause-and-verify gate.
- **The Supabase MCP uses `--scope project`**, the command from the dashboard's Connect menu, because it's tied to one database. Context7 stays `--scope user` from the SPA lecture.

## Before you teach

- [ ] Follow `demo-kit/RUNBOOK.md`: dry run, then reset (delete the dry-run project, so you have a free project slot)
- [ ] Teacher guide and answer keys: `/mnt/storage/CP/Cohorts/eagle/Notes/`
