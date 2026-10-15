# The database prompt (paste into Claude Code from the database folder, ~/demos/ticked/supabase)

Before you paste it, the folder should contain:
- `user_stories.md`
- `task-manager-erd.png`, the DrawSQL screenshot (DrawSQL's free plan can't export, so a screenshot is our diagram)
- the Supabase MCP, connected and authenticated (`/mcp` shows supabase)
- the `postgresql-table-design` skill (`/skills` shows it)

---

I'm building a task management application where people create projects and tasks, and label tasks with tags. There's no login screen yet; that comes later. I have some resources I'd like you to look at and supervise:

Here is my DrawSQL schema diagram (a screenshot):
@task-manager-erd.png

Here are my user stories:
@user_stories.md

My Supabase project is already connected in this directory through the supabase MCP.

Please:
1. Use the `postgresql-table-design` skill and the Context7 MCP to update your context on the documentation for Supabase and PostgreSQL.
2. Write the SQL schema for my diagram into `schema.sql`. Confirm it matches the diagram and the user stories, and list anything you'd change to follow database best practices, including Supabase's Row Level Security. Don't change my design on your own: tell me, and I'll decide. Then stop so I can review it.
3. After I approve, create the tables in my Supabase project **ONE AT A TIME**.
4. After each table, pause and tell me what you did so I can verify it in the dashboard before you continue.

Is there any additional information you may need from me?
