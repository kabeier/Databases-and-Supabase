// =====================================================================
// db.js: the ONLY file in Ticked that reads or changes data.
//
// This version talks to Supabase (a real PostgreSQL database) through
// supabase-js. The tables match schema.sql:
//
//   projects   (id, name, description, created_at)
//   tasks      (id, title, is_complete, due_date, project_id, created_at)
//   tags       (id, name)
//   task_tags  (task_id, tag_id)   <- joins tasks and tags (many-to-many)
//
// Every function keeps the same name, inputs and return value as the
// in-memory version, so no page or component had to change.
//
// The database does the work the arrays used to do by hand:
//   - ids and created_at come from the column defaults
//   - deleting a project sets its tasks' project_id to null (ON DELETE SET NULL)
//   - deleting a task removes its task_tags rows (ON DELETE CASCADE)
//
// Row Level Security is on. The app has no logins yet, so it relies on
// the dev-only policies in dev-policies.sql.
// =====================================================================
import { supabase } from './supabaseClient'

// supabase-js returns { data, error } instead of throwing. This turns an
// error into a thrown Error, so the context can show it in the banner.
function check({ data, error }) {
  if (error) throw new Error(error.message)
  return data
}

// =====================================================================
// PROJECTS
// =====================================================================

// All projects, oldest first.
export async function listProjects() {
  return check(await supabase.from('projects').select('*').order('created_at', { ascending: true }))
}

// Add a project. Returns the new row.
export async function createProject({ name, description }) {
  return check(
    await supabase
      .from('projects')
      .insert({ name: name, description: description || null })
      .select()
      .single(),
  )
}

// Remove a project. Its tasks stay, but lose their project
// (the database's ON DELETE SET NULL does that for us).
export async function deleteProject(id) {
  check(await supabase.from('projects').delete().eq('id', id))
}

// =====================================================================
// TASKS
// =====================================================================

// All tasks, newest first. Each task comes back with a `tags` array
// ([{ id, name }, ...]) joined in through task_tags.
export async function listTasks() {
  // "tags(id, name)" asks Supabase to follow task_tags to the tags table
  const rows = check(
    await supabase.from('tasks').select('*, tags(id, name)').order('created_at', { ascending: false }),
  )
  return rows.map((task) => ({ ...task, tags: task.tags || [] }))
}

// Add a task (not complete yet) and link it to its tags. Returns the new row.
export async function createTask({ title, project_id, due_date, tagIds }) {
  const task = check(
    await supabase
      .from('tasks')
      .insert({ title: title, due_date: due_date || null, project_id: project_id || null })
      .select()
      .single(),
  )

  if (tagIds && tagIds.length > 0) {
    const pairs = tagIds.map((tagId) => ({ task_id: task.id, tag_id: tagId }))
    check(await supabase.from('task_tags').insert(pairs))
  }
  return task
}

// Tick a task off (true) or re-open it (false).
export async function setTaskComplete(id, is_complete) {
  check(await supabase.from('tasks').update({ is_complete: is_complete }).eq('id', id))
}

// Remove a task (its tag pairings go with it: ON DELETE CASCADE).
export async function deleteTask(id) {
  check(await supabase.from('tasks').delete().eq('id', id))
}

// =====================================================================
// TAGS
// =====================================================================

// All tags, A to Z.
export async function listTags() {
  return check(await supabase.from('tags').select('*').order('name'))
}

// Add a tag. Returns the new row.
export async function createTag(name) {
  return check(await supabase.from('tags').insert({ name: name }).select().single())
}
