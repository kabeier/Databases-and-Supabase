# The connect prompt (paste into the SAME Claude session, after the tables are built)

Before you paste it:
- All four tables exist in Supabase and you've checked them in the Table Editor.
- You're in the app folder (`~/demos/task-manager`), the same folder the Supabase MCP was added in.

---

Now let's connect my app to this database.

@src/data/db.js is the only file in my app that reads or writes data. Right now it keeps everything in memory, so a refresh wipes it.

Please:
1. Use the Context7 MCP to look up the current `supabase-js` docs before you write any code.
2. Use the Supabase MCP to check my tables. Row Level Security is on and my app has no logins yet. Propose the policies the app needs, explain each one in plain English, and wait for my OK before you create them.
3. Install `@supabase/supabase-js`. Put my project URL and my publishable (anon) key in `.env.local`. Never the secret / service_role key.
4. Rewrite `src/data/db.js` to use Supabase. Keep every function name, its inputs and what it returns, so no page or component has to change. Don't change any other files except what's needed to create the Supabase client.
5. Don't add sample data. I'll start with an empty database.
6. When you're done, stop and tell me how to run it, so I can test it: add a task, refresh, and check the Table Editor.
