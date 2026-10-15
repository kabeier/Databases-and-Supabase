// One shared Supabase client for the whole app.
// The URL and the publishable (anon) key come from .env.local (see .env.example).
// The publishable key is safe in the browser: Row Level Security policies decide what it can do.
// NEVER put the secret (service_role) key here.
import { createClient } from '@supabase/supabase-js'

const url = import.meta.env.VITE_SUPABASE_URL
const key = import.meta.env.VITE_SUPABASE_PUBLISHABLE_KEY

if (!url || !key) {
  throw new Error('Missing VITE_SUPABASE_URL or VITE_SUPABASE_PUBLISHABLE_KEY. Copy .env.example to .env.local, fill it in, and restart npm run dev.')
}

export const supabase = createClient(url, key)
