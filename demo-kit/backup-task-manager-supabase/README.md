# Ticked (Task Manager), connected to Supabase

The same app as [`../backup-task-manager`](../backup-task-manager), after Lecture 2's prompt 2
([`../connect-prompt.md`](../connect-prompt.md)). This is the backup if the live connection stalls.

Only two files differ from the in-memory version:
- [`src/data/db.js`](src/data/db.js): the same functions, now reading and writing Supabase with `supabase-js`
- [`src/data/supabaseClient.js`](src/data/supabaseClient.js): creates the one shared Supabase client

Nothing else changed (plus `@supabase/supabase-js` in `package.json`).

## Run it

1. In your Supabase project, run [`../schema.sql`](../schema.sql), then [`../dev-policies.sql`](../dev-policies.sql), in the SQL Editor. Skip this if Claude already built the tables and policies.
2. Set up the keys and start the app:
   ```bash
   cp .env.example .env.local     # fill in the URL and the PUBLISHABLE key
   npm install && npm run dev
   ```
   The values are in the Supabase dashboard: **Connect** (top bar) → **App Frameworks**, or **Project Settings → API Keys**.

The app starts empty: the database has no rows yet. Add a project and a task, refresh, and they're still there.

**Security:**
- `.env.local` is git-ignored.
- Never put the secret (`service_role`) key in it.
- The dev policies let anyone with the publishable key read and write every row. That's fine for a class project with fake data; replace them when logins arrive.

**Tested** against PostgreSQL 18 with the same schema and policies, through PostgREST (the API server Supabase runs), in October 2026.
