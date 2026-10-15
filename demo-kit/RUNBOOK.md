# Live demo runbook: Ticked (Task Manager) + its database

**The story for students:** Ticked is the app we built in the SPA lectures (it stands in for Liftlog). It works, but it forgets everything on refresh.
- **Lecture 1:** show that, explain why we need a database, and draw Ticked's database in DrawSQL, live.
- **Lecture 2:** create the Supabase project, connect the MCP, install the skill, have Claude build the tables, and explore them in the dashboard. All live.

At the end we have a front-end and a database, but **they can't talk yet**. Connecting them through an API is a future lecture.

**Folder layout (matches the full-stack lecture):**
```
~/demos/ticked/
├── front-end/   Ticked + app_outline + CLAUDE.md + .claude/ (design skills, front-end-agent)
└── supabase/    made live in Lecture 2: .mcp.json, .claude/ (db skill, supabase-agent),
                 user_stories.md, task-manager-erd.png, schema.sql
```
In a future lecture the two `.claude/` folders merge into one at `ticked/`, and Claude connects the halves.

## What's in the kit

| File | What it is |
|---|---|
| `backup-task-manager/` | Ticked as the SPA lectures left it: the app, plus `app_outline/`, the `CLAUDE.md` from `/init`, `.claude/skills/` (the 4 design skills) and `.claude/agents/front-end-agent.md`. The data is in memory only. Live on the class site at `/task-manager/`. |
| `app_outline/`, `app-prompt.md` | Ticked's spec and the build prompt it came from (same layout as Liftlog's). |
| `user_stories.md`, `task-manager-erd.png` | Lecture 2 inputs for Claude. |
| `prompt.md` | The database prompt. |
| `schema.sql` | Backup for the prompt: paste into Supabase's SQL Editor. Tested on PostgreSQL 18. |
| `.claude/agents/` | `front-end-agent.md` (from the SPA lectures) and `supabase-agent.md` (word for word from the reading). |
| `setup-db-skill.sh` | Installs the postgresql-table-design skill. |

## Setup (do once, before Lecture 1)

```bash
node -v                      # Node 20.19+ or 22.12+
claude -v                    # Claude Code installed and logged in
claude mcp list              # context7 should be there from the SPA lecture

# Put the demo kit somewhere short, so the live commands are easy to type
cp -r /mnt/storage/CP/new_Lectures/claude-supabase-db/demo-kit ~/db-kit
mkdir -p ~/demos/ticked
cp -r ~/db-kit/backup-task-manager ~/demos/ticked/front-end
cd ~/demos/ticked/front-end && npm install
```

Log in to supabase.com in the browser you'll present from.

## Lecture 1

Nothing to install. Before class:

1. Open Ticked: `https://kabeier.github.io/Databases-and-Supabase/task-manager/`, or `npm run dev` in `~/demos/ticked/front-end`.
2. Open `https://drawsql.app/draw`, pick **PostgreSQL**, then **Start with a blank canvas**.
3. Have `user_stories.md` open to read from, and `task-manager-erd.png` as the backup picture.
4. **Running long at slide 12?** Use **File → Import** and paste the `create table` part of `schema.sql`. It creates all five tables with their lines (it replaces the canvas).

**Slide 3, live:** add a task, tick another one, refresh. Both changes are gone.

**Drawing happens in two parts:**
- **Slide 12:** `users`, `projects` and `tasks`, with columns and types and no lines.
- **Slide 16:** the three lines (`projects.user_id`, `tasks.user_id`, `tasks.project_id`), then `tags` and `task_tags` with their two lines, then the screenshot.

How DrawSQL works (checked October 2026):
- **Add table**: the first icon in the small toolbar at the top left, then click the canvas.
- Columns are edited in the left panel. Each row has a name, a type, **N** (nullable) and a key icon (primary key). **Add Column** adds more, and the pencil icon renames the table. The `…` button on a column has **Delete column**.
- **Relationships**: hover a column, and dots appear on its edges. Drag from the foreign key column's dot onto the column it points at. A popup offers 1:1, 1:N or N:1.
- **Moving a table**: drag its header slowly. A fast drag pans the canvas instead.
- **File → Import** is free. **File → Export** is locked on the free plan, so take a screenshot instead.
- With no account, the diagram lives in that browser's storage only.

## Lecture 2, the night before: dry run once

1. In Supabase, create a **New project** called `task-manager-dryrun` and wait for it.
2. Follow the in-class steps below: supabase folder, MCP, skill, copy files, prompt, review, build, explore. From pasting the prompt to the last table takes about 10 minutes.
3. Note where Supabase puts **Connect → MCP → Claude Code** today, what Claude asks you to approve, and how inserting a row with a foreign key looks in the Table Editor.

## Lecture 2, the night before: reset

```bash
rm -rf ~/demos/ticked/supabase       # removes .mcp.json, the db skill, the agent and Claude's files
```

`front-end/` is untouched by Lecture 2, so it stays.

In Supabase, delete the dry-run project (Project Settings → General → Delete project). The free tier allows 2 active projects, and you need a free slot to create one live.

## Backup

If the build stalls: Supabase → **SQL Editor** → paste `schema.sql` → **Run**. It creates all five tables and the foreign key indexes, and turns on RLS.

## In class (Lecture 2)

One terminal in `~/demos/ticked`. Add a second tab when you install the skill.

| Slide (~min) | Where | Do | Say |
|---|---|---|---|
| 7 (~7) | browser | **New project** form, top to bottom: Organization (point at it: "first sign-in, you create one"), GitHub empty, name `task-manager`, **Generate → Copy → save the password**, Region closest, Security: keep **Enable Data API** ✓ and **Automatically expose new tables** ✓, turn **Enable automatic RLS** ✓ on, Advanced untouched → Create | "A real PostgreSQL server, just for us, in about 90 seconds." |
| 8 (~9) | browser | Tour: Table Editor, SQL Editor, Database, then point at **Connect** | "This is where you check Claude's work." |
| 9 (~11) | terminal 1 | `cd ~/demos/ticked` (the project root), `ls` (just `front-end/`), `mkdir supabase`, `cd supabase`. Paste the command from **Connect → MCP → Claude Code**. Then `claude`, trust the folder, **Use this MCP server**, `/mcp` → supabase → **Authenticate** | "The database gets its own folder, next to the front-end. Project scope: this MCP belongs to this folder and this database." |
| 10 (~14) | terminal 2 | `cd ~/demos/ticked/supabase` and the `setup-db-skill.sh` one-liner, then `/skills` in Claude | "A skill is a folder of rules." |
| 11 (~16) | terminal 2 | `cp ~/db-kit/user_stories.md ~/db-kit/task-manager-erd.png .` | "Don't come empty-handed." |
| 13 (~18) | Claude | Paste the prompt from `prompt.md`. Approve file edits for the session; approve each Supabase call one by one | "I approve the plan, and I check every table." |
| 13 (~18–24) | browser | Approve or Push Back activity while Claude researches and writes `schema.sql` | — |
| 15 (~25) | Claude + browser | Review `schema.sql` out loud (5 tables, RLS on), approve, then check each table in the Table Editor. At the end: Database → Schema Visualizer | "Looks right? Continue. Looks wrong? Stop." |
| 16 (~31) | browser | Explore: insert a user, a project (pick the user), a task (pick user + project), a tag, a task_tags row. Try a bad row, run the join in the SQL Editor, delete the project | "Every rule we drew is enforced now." |
| 17 (~36) | browser | Open Ticked, add a task, refresh: still gone | "Front-end ✓, database ✓, not connected yet. Future lecture." |
| 18 (~38) | terminal 2 | `mkdir -p .claude/agents && cp ~/db-kit/.claude/agents/supabase-agent.md .claude/agents/`, then `/agents` in Claude | "The front-end has its agent, now the database has one." |

Claude asks permission before it edits files or calls a tool. For file edits, pick **"Yes, allow all edits during this session"**. For **Supabase MCP calls, approve each one** and read it out loud: that's the lesson.

**Time check:** if the tables aren't done by ~min 29, check the first two carefully, then tell Claude to finish the rest and pause at the end. Exploring can shrink to one insert with a foreign key plus the Schema Visualizer.

## Heads-up for the next lectures

- **Full-stack lecture (RESTful APIs, then connecting it all):** the Postman exercise calls `/users` and `/tasks` with the **publishable key**. RLS is on with no rules, so reads return `[]` and writes are refused (401/403), until temporary dev rules are added. The supabase-agent can propose those, and you approve them. That lecture's status-code table lists "403: RLS policy violation", so this can be a teaching moment. Its folder layout is `ticked/` with `front-end/`, `supabase/` and one shared `.claude/`.
- **Authentication lecture:** backs up and drops these tables, rebuilds `users` as a mirror of `auth.users` (via a trigger), and adds RLS rules on `user_id`. `tasks.user_id` and `projects.user_id` are already in place for that.
