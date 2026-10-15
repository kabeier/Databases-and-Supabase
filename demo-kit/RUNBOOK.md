# Live demo runbook: Ticked (Task Manager) + its database

**The story for students:** Ticked is the app we built in the SPA lectures (it stands in for Liftlog). It works, but it forgets everything on refresh.
- **Lecture 1:** show that, explain why we need a database, and draw Ticked's database in DrawSQL, live.
- **Lecture 2:** create the Supabase project, connect the MCP, install the skill, have Claude build the tables, and explore them in the dashboard. All live.

At the end we have a front-end and a database, but **they can't talk yet**: that needs an API, which comes in a future lecture.

The night before Lecture 2, you get your machine ready and do one dry run.

## What's in the kit

| File | What it is |
|---|---|
| `backup-task-manager/` | Ticked, as the SPA lectures left it. It has the app, plus `app_outline/`, the `CLAUDE.md` from `/init`, `.claude/skills/` (the 4 design skills) and `.claude/agents/front-end-agent.md`. The data is in memory only. Live on the class site at `/task-manager/`. |
| `app_outline/`, `app-prompt.md` | Ticked's spec and the build prompt it came from (same layout as Liftlog's). |
| `user_stories.md`, `task-manager-erd.png` | Lecture 2 inputs for Claude. |
| `prompt.md` | The database prompt. |
| `schema.sql` | Backup for the prompt: paste it into Supabase's SQL Editor. Tested on PostgreSQL 18. |
| `.claude/agents/` | `front-end-agent.md` (from the SPA lectures) and `supabase-agent.md` (word for word from the reading). |
| `setup-db-skill.sh` | Installs the postgresql-table-design skill. |

## Lecture 1

Nothing to install. Before class:

1. Open Ticked: `https://kabeier.github.io/Databases-and-Supabase/task-manager/`, or run your copy with `npm run dev`.
2. Open `https://drawsql.app/draw`, pick **PostgreSQL**, then **Start with a blank canvas**.
3. Have `user_stories.md` open to read from, and `task-manager-erd.png` as the backup picture.
4. If you run long at slide 12, use **Import SQL** (left panel) and paste the `create table` part of `schema.sql`, which creates all four tables at once.

**Slide 3, live:** add a task, tick another one, refresh. Both changes are gone.

**Drawing happens in two parts:**
- Slide 12: `projects` and `tasks`, with columns and types and no lines.
- Slide 16: the line from tasks to projects, then `tags` and `task_tags` and their lines, then the screenshot.

How DrawSQL works (checked October 2026):
- **Add table**: the first icon in the small toolbar at the top left, then click the canvas.
- **Columns** are edited in the left panel. Each row has a name, a type, **N** (nullable) and a key icon (primary key).
  - **Add Column** adds more.
  - The pencil icon renames the table.
  - The `…` button on a column has **Delete column**.
- **Relationships**: hover a column, and dots appear on its edges. Drag from the foreign key column's dot onto the column it points at. A popup offers 1:1, 1:N or N:1.
- **File → Export** is locked on the free plan. Take a screenshot instead.
- With no account, the diagram lives in that browser's storage only.

## Lecture 2, the night before: get ready

```bash
node -v                      # Node 20.19+ or 22.12+
claude -v                    # Claude Code installed and logged in
claude mcp list              # context7 should be there from the SPA lecture

# Put the demo kit somewhere short, so the live commands are easy to type
cp -r /mnt/storage/CP/new_Lectures/claude-supabase-db/demo-kit ~/db-kit
mkdir -p ~/demos
cp -r ~/db-kit/backup-task-manager ~/demos/task-manager
cd ~/demos/task-manager && npm install
```

Log in to supabase.com in the browser you'll present from.

## Lecture 2, the night before: dry run once

1. Supabase → **New project** `task-manager-dryrun`. Wait for it.
2. Follow the in-class steps below: MCP, skill, copy files, prompt, review, build, explore. Time the prompt: from paste to the last table should take about 9 minutes.
3. Note where Supabase puts **Connect → MCP → Claude Code** today, what Claude asks you to approve, and how inserting a row with a foreign key looks in the Table Editor.

## Lecture 2, the night before: reset

```bash
rm -rf ~/demos/task-manager          # removes .mcp.json, the db skill and Claude's files
cp -r ~/db-kit/backup-task-manager ~/demos/task-manager
cd ~/demos/task-manager && npm install
```

In Supabase, delete the dry-run project (Project Settings → General → Delete project). The free tier allows 2 active projects, and you need a free slot to create one live.

## Backup

If the build stalls, go to Supabase → **SQL Editor**, paste `schema.sql`, and click **Run**. It creates all four tables and the foreign key indexes, and turns on RLS.

## In class (Lecture 2)

One terminal in `~/demos/task-manager`. Add a second tab when you install the skill.

| Slide (~min) | Where | Do | Say |
|---|---|---|---|
| 7 (~7) | browser | **New project** `task-manager`, generate a password, pick a region, Free, Create | "A real PostgreSQL server, just for us, in about 90 seconds." |
| 8 (~9) | browser | Tour: Table Editor, SQL Editor, Database, then point at **Connect** | "This is where you check Claude's work." |
| 9 (~11) | terminal 1 | `cd ~/demos/task-manager`, then run the command from **Connect → MCP → Claude Code**. Then `claude`, trust the folder, **Use this MCP server**, and `/mcp` → supabase → **Authenticate** | "Project scope: this MCP belongs to this one folder and this one database." |
| 10 (~14) | terminal 2 | `cd ~/demos/task-manager` and the `setup-db-skill.sh` one-liner, then `/skills` in Claude | "A skill is a folder of rules." |
| 11 (~16) | terminal 2 | `cp ~/db-kit/user_stories.md ~/db-kit/task-manager-erd.png .` | "Don't come empty-handed." |
| 13 (~18) | Claude | Paste the prompt from `prompt.md`. Approve file edits for the session; approve each Supabase call one by one | "I approve the plan, and I check every table." |
| 13 (~18–24) | browser | Approve or Push Back activity while Claude researches and writes `schema.sql` | — |
| 15 (~25) | Claude + browser | Review `schema.sql` out loud (4 tables, RLS on), approve, then check each table in the Table Editor. At the end: Database → Schema Visualizer | "Looks right? Continue. Looks wrong? Stop." |
| 16 (~31) | browser | Explore: insert a project, a task (pick its project), a tag, a task_tags row; try a bad row; run the join in the SQL Editor; delete the project | "Every rule we drew is enforced now." |
| 17 (~36) | browser | Open Ticked, add a task, refresh: still gone | "Front-end ✓, database ✓, no API yet. Future lecture." |

Claude asks permission before it edits files or calls a tool. For file edits, pick **"Yes, allow all edits during this session"**. For **Supabase MCP calls, approve each one** and read it out loud: that's the lesson.

**Time check:** if the tables aren't done by ~min 29, check the first two carefully, then tell Claude to finish the rest and pause at the end. Exploring can shrink to the Table Editor and the Schema Visualizer.
