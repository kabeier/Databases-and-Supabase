# Live demo runbook: Ticked (Task Manager) + its database

- **Lecture 1:** show Ticked forgetting your data on refresh, then draw its database in DrawSQL, live.
- **Lecture 2:** create the Supabase project, connect the MCP, install the skill, have Claude build the tables, then have Claude plug Ticked into them. All live.

The night before Lecture 2, you get your machine ready and do one dry run.

## What's in the kit

| File | What it is |
|---|---|
| `app_outline/` | Ticked's spec: user journey, `app.png`, style guide, one folder per page (wireframe + user story). Same layout as Liftlog's. |
| `app-prompt.md` | The build prompt Ticked was built from (same as the Liftlog prompt, plus "keep all data code in one file"). |
| `backup-task-manager/` | Ticked, finished. Data in memory only. This is what you show and connect. Live on the class site at `/task-manager/`. |
| `backup-task-manager-supabase/` | Ticked after the Lecture 2 connection. Backup only. |
| `user_stories.md`, `task-manager-erd.png` | Lecture 2 inputs for Claude. |
| `prompt.md` | Prompt 1: build the tables. |
| `connect-prompt.md` | Prompt 2: connect Ticked to them. |
| `schema.sql`, `dev-policies.sql` | Backups for prompts 1 and 2 (paste into Supabase's SQL Editor). Both tested on PostgreSQL 18. |
| `.claude/agents/` | `front-end-agent.md` (from the SPA lectures) and `supabase-agent.md` (from the reading). |

## Lecture 1

Nothing to install. Before class:

1. Open Ticked: `https://kabeier.github.io/Databases-and-Supabase/task-manager/`. Or run it locally: `cd demo-kit/backup-task-manager && npm install && npm run dev`.
2. Open `https://drawsql.app/draw`, pick **PostgreSQL**, then **Start with a blank canvas**.
3. Have `user_stories.md` open to read from, and `task-manager-erd.png` as the backup picture.
4. If you run long at slide 12, use **Import SQL** (left panel) and paste `schema.sql` (the `create table` part) to create all four tables at once.

Slide 3, live: add a task, tick another one, refresh. Both changes are gone.

How DrawSQL works (checked October 2026):
- **Add table**: the first icon in the small toolbar at the top left, then click the canvas.
- Columns are edited in the left panel. Each row has a name, a type, **N** (nullable) and a key icon (primary key). Use **Add Column** for more. The pencil icon renames the table. The `…` button on a column has **Delete column**.
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
```

Log in to supabase.com in the browser you'll present from.

## Lecture 2, the night before: dry run once

```bash
cp -r ~/db-kit/backup-task-manager ~/demos/task-manager
cd ~/demos/task-manager && npm install
```

1. Supabase → **New project** `task-manager-dryrun`. Wait for it.
2. Follow the in-class steps below: MCP, skill, copy files, prompt 1, then prompt 2, then the refresh test. Time each part:
   - prompt 1: about 9 minutes, from paste to the last table
   - prompt 2: about 6 minutes, to a working refresh
3. Note where Supabase puts **Connect → MCP → Claude Code** today, what Claude asks you to approve, and what the policies it proposes look like.

## Lecture 2, the night before: reset

```bash
rm -rf ~/demos/task-manager          # removes .mcp.json, the skill, .env.local and Claude's changes
cp -r ~/db-kit/backup-task-manager ~/demos/task-manager
cd ~/demos/task-manager && npm install   # fresh in-memory Ticked, ready for class
```

In Supabase, delete the dry-run project (Project Settings → General → Delete project). The free tier allows 2 active projects, and you need a free slot to create one live.

## Backups

- **Tables stall:** Supabase → **SQL Editor** → paste `schema.sql` → **Run**. It creates all four tables, the foreign key indexes, and turns on RLS.
- **Policies stall:** paste `dev-policies.sql` in the SQL Editor and run it.
- **db.js rewrite stalls:**
  ```bash
  cd ~/db-kit/backup-task-manager-supabase && npm install
  cp .env.example .env.local    # then fill in the URL and publishable key from Connect → App frameworks (or Project Settings → API Keys)
  npm run dev
  ```

## In class (Lecture 2)

One terminal in `~/demos/task-manager`. Add a second tab when you install the skill.

| Slide (~min) | Where | Do | Say |
|---|---|---|---|
| 7 (~7) | browser | **New project** `task-manager`, generate a password, pick a region, Free, Create | "A real PostgreSQL server, just for us, in about 90 seconds." |
| 8 (~9) | browser | Tour: Table Editor, SQL Editor, Database, then point at **Connect** | "This is where you check Claude's work." |
| 9 (~11) | terminal 1 | `cd ~/demos/task-manager`, then the command from **Connect → MCP → Claude Code**. Then `claude`, trust, **Use this MCP server**, `/mcp` → supabase → **Authenticate** | "Project scope: this MCP belongs to this one folder and this one database." |
| 10 (~14) | terminal 2 | `cd ~/demos/task-manager` and the `setup-db-skill.sh` one-liner, then `/skills` in Claude | "A skill is a folder of rules." |
| 11 (~16) | terminal 2 | `cp ~/db-kit/user_stories.md ~/db-kit/task-manager-erd.png .` | "Don't come empty-handed." |
| 13 (~18) | Claude | Paste prompt 1 from `prompt.md`. Approve file edits for the session; approve each Supabase call one by one | "I approve the plan, and I check every table." |
| 13 (~18–22) | browser | Approve or Push Back activity (core 8) while Claude researches and writes `schema.sql` | — |
| 15 (~23) | Claude + browser | Review `schema.sql` out loud (4 tables, RLS on), approve, then check each table in the Table Editor. At the end: Database → Schema Visualizer | "Looks right? Continue. Looks wrong? Stop." |
| 17 (~30) | Claude | Paste prompt 2 from `connect-prompt.md` in the same session | "One file changes. That's why we planned the data layer." |
| 18 (~31) | Claude, terminal 2, browser | Read the proposed policies out loud, approve. When done: `npm run dev`, add a project + task + tag, tick it, **refresh**. Then show the rows in the Table Editor | "In Lecture 1 a refresh wiped it. Now it's in PostgreSQL." |

Claude asks permission before it edits files or calls a tool. For file edits, pick **"Yes, allow all edits during this session"**. For **Supabase MCP calls, approve each one** and read it out loud: that's the lesson.

**Time checks:**
- If the tables aren't done by ~min 28, check the first two carefully, then tell Claude to finish the rest and pause at the end.
- If you reach slide 17 after ~min 33, run the `schema.sql` and `dev-policies.sql` backups. Then use `backup-task-manager-supabase` for the refresh test.

**After editing `.env.local`, restart `npm run dev`:** Vite only reads it at start-up. Vite's `.gitignore` already ignores `*.local`, so the keys stay out of git.
