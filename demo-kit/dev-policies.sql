-- Backup: the Lecture 2 RLS policies that let the Task Manager app (no logins yet) read and write.
-- In class, Claude proposes these and you approve them. Use this only if that stalls.
--
-- DEV ONLY. "to anon ... using (true)" means anyone holding the app's public (publishable/anon) key
-- can read and change every row. That's fine for a class demo project with fake data.
-- When accounts arrive in a future lecture, these get replaced with rules like
-- "you can only see your own tasks".

create policy "dev: anyone can read projects"   on public.projects  for select to anon using (true);
create policy "dev: anyone can add projects"    on public.projects  for insert to anon with check (true);
create policy "dev: anyone can change projects" on public.projects  for update to anon using (true) with check (true);
create policy "dev: anyone can delete projects" on public.projects  for delete to anon using (true);

create policy "dev: anyone can read tasks"      on public.tasks     for select to anon using (true);
create policy "dev: anyone can add tasks"       on public.tasks     for insert to anon with check (true);
create policy "dev: anyone can change tasks"    on public.tasks     for update to anon using (true) with check (true);
create policy "dev: anyone can delete tasks"    on public.tasks     for delete to anon using (true);

create policy "dev: anyone can read tags"       on public.tags      for select to anon using (true);
create policy "dev: anyone can add tags"        on public.tags      for insert to anon with check (true);

create policy "dev: anyone can read task_tags"   on public.task_tags for select to anon using (true);
create policy "dev: anyone can add task_tags"    on public.task_tags for insert to anon with check (true);
create policy "dev: anyone can delete task_tags" on public.task_tags for delete to anon using (true);
