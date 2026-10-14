# Live demo runbook: Task Manager database

Lecture 1 draws the Task Manager in DrawSQL, live. Lecture 2 creates the Supabase project, connects the MCP, installs the skill, and has Claude build the tables, all live. The night before, you only get your machine ready and do one dry run.

## Lecture 1 (DrawSQL)

Nothing to install. Before class:

1. Open `https://drawsql.app/draw`, pick **PostgreSQL**, then **Start with a blank canvas**.
2. Have `user_stories.md` open to read from, and `task-manager-erd.png` as the backup picture.
3. If you run long at slide 12, use **Import SQL** (left panel) and paste `schema.sql` to create all five tables at once.

How DrawSQL works (checked October 2026):
- **Add table**: the first icon in the small toolbar at the top left, then click the canvas.
- Columns are edited in the left panel. Each row has a name, a type, **N** (nullable) and a key icon (primary key). Use **Add Column** for more. The pencil icon renames the table.
- **Relationships**: hover a column, and dots appear on its edges. Drag from the foreign key column's dot onto the column it points at. A popup offers 1:1, 1:N or N:1.
- **File → Export** is locked on the free plan. Take a screenshot instead.
- With no account, the diagram lives in that browser's storage only.

## Lecture 2, the night before: get ready

```bash
claude -v                    # Claude Code installed and logged in
claude mcp list              # context7 should be there from the SPA lecture

# Put the demo kit somewhere short, so the live commands are easy to type
cp -r /mnt/storage/CP/new_Lectures/claude-supabase-db/demo-kit ~/db-kit
mkdir -p ~/demos
```

Log in to supabase.com in the browser you'll present from.

## Lecture 2, the night before: dry run once

1. Supabase → **New project** `task-manager-dryrun`. Wait for it.
2. Follow the in-class steps below (MCP, skill, copy files, prompt). Time how long Claude takes to write `schema.sql` and to build the five tables.
3. Note where Supabase puts **Connect → MCP → Claude Code** today, and what Claude asks you to approve.

## Lecture 2, the night before: reset

```bash
rm -rf ~/demos/task-manager-db   # the folder holds .mcp.json and the skill, so this removes both
```

In Supabase, delete the dry-run project (Project Settings → General → Delete project). The free tier allows 2 active projects, and you need a free slot to create one live.

## Backup

If the build stalls in class, open the **SQL Editor** in Supabase, paste `schema.sql`, and click Run. It creates all five tables plus the foreign key indexes. (Tested on PostgreSQL 18.)

## In class (Lecture 2)

One terminal in `~/demos`. Add a second tab when you install the skill.

| Slide (~min) | Where | Do | Say |
|---|---|---|---|
| 7 (~9) | browser | **New project** `task-manager`, generate a password, pick a region, Free, Create | "A real PostgreSQL server, just for us, in about 90 seconds." |
| 8 (~11) | browser | Tour: Table Editor, SQL Editor, Database, then point at **Connect** | "This is where you check Claude's work." |
| 9 (~14) | terminal 1 | `mkdir -p ~/demos/task-manager-db && cd ~/demos/task-manager-db`, then the command from **Connect → MCP → Claude Code**. Then `claude`, trust, **Use this MCP server**, `/mcp` → supabase → **Authenticate** | "Project scope: this MCP belongs to this one folder and this one database." |
| 10 (~18) | terminal 2 | `cd ~/demos/task-manager-db` and the `setup-db-skill.sh` one-liner, then `/skills` in Claude | "A skill is a folder of rules." |
| 11 (~20) | terminal 2 | `cp ~/db-kit/user_stories.md ~/db-kit/task-manager-erd.png .` | "Don't come empty-handed." |
| 13 (~22) | Claude | Paste the prompt from `prompt.md`. Approve file edits for the session; approve each Supabase call one by one | "I approve the plan, and I check every table." |
| 13 (~22–28) | browser | Approve or Push Back activity while Claude researches and writes `schema.sql` | — |
| 15 (~29) | Claude + browser | Review `schema.sql` out loud, approve, then check each table in the Table Editor. At the end: Database → Schema Visualizer | "Looks right? Continue. Looks wrong? Stop." |
| 17 (~38) | terminal 2 | Optional: `mkdir -p .claude/agents && cp ~/db-kit/.claude/agents/supabase-agent.md .claude/agents/`, then `/agents` | "Set it up once, reuse it everywhere." |

Claude asks permission before it edits files or calls a tool. For file edits, pick **"Yes, allow all edits during this session"**. For **Supabase MCP calls, approve each one** and read it out loud: that's the lesson.

If the tables aren't done by ~min 35, check the first two carefully, then tell Claude to finish the rest and pause at the end. If it's really stuck, use the backup above.
