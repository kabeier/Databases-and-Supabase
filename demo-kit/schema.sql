-- Backup: the Task Manager schema from the Lecture 1 DrawSQL diagram.
-- In class, Claude writes its own schema.sql from the screenshot. Use this only if that stalls.
-- Order matters: a table must exist before another table can point a foreign key at it.

create table public.users (
  id          uuid primary key default gen_random_uuid(),
  name        varchar(100) not null,
  email       varchar(255) not null unique,
  created_at  timestamptz  not null default now()
);

create table public.projects (
  id          uuid primary key default gen_random_uuid(),
  name        varchar(255) not null,
  description text,
  owner_id    uuid not null references public.users (id),
  created_at  timestamptz  not null default now()
);

create table public.tasks (
  id          uuid primary key default gen_random_uuid(),
  title       varchar(255) not null,
  is_complete boolean      not null default false,
  due_date    date,
  project_id  uuid references public.projects (id),
  created_by  uuid not null references public.users (id),
  created_at  timestamptz  not null default now()
);

create table public.tags (
  id    uuid primary key default gen_random_uuid(),
  name  varchar(50) not null unique
);

-- Junction table: tasks <-> tags is many-to-many
create table public.task_tags (
  task_id  uuid not null references public.tasks (id),
  tag_id   uuid not null references public.tags (id),
  primary key (task_id, tag_id)
);

-- PostgreSQL does not index foreign key columns for you
create index on public.projects (owner_id);
create index on public.tasks (project_id);
create index on public.tasks (created_by);
create index on public.task_tags (tag_id);
