# The app build prompt (Ticked, the Task Manager)

This is the same kind of build as the Liftlog demo in the SPA lectures, run from a fresh Vite project with `app_outline/` copied in. You don't run it in class: the finished result is `backup-task-manager/`, which you show in Lecture 1 and connect to Supabase in Lecture 2. It's here so you (and students) can see exactly how the app was specified.

---

I would like you to build a Front-End Single Page Application from the wire frames and user stories I have mapped out.

The tech-stack for this application will be as follows:
- React.js + Vite
- React Router DOM with Browser Router

Skills necessary for this application are as follows:
- Front-End Design
- UI UX Pro Max
- Taste
- Design Motion Principles

There will be no API interactions and all data should be retained only at the browser level, meaning if I refresh/rerender my site all of the data should reset. Keep every read and write of data in ONE data-layer file, shaped like the database tables we'll create later (projects, tasks, tags, task_tags), so that swapping in a real database later only touches that file.

I have created a series of documents and images as a reference for what I would like this application to look like and isolated everything by pages. Take a look at this folder @./app_outline and read the `user_journey.md` file to get context for the users journey through the application. Then look at the `app.png` to visualize the entire application. Finally under pages, you'll find a wire-frame corresponding to each page along with a detailed user story for how a user would interact with this page. Additionally, when it comes to design style, you can read the `style_guide.md` and apply its guidelines as you see fit.

Use the Context7 MCP to gather all relevant documentation for our tech stack.

Ensure to utilize the `playwright` & `Chrome Dev Tools` MCP servers to supervise the development of this Application. After each page is built, use Playwright to screenshot it and compare against the wireframe before moving on and ensuring it's output matches the desired outcome from the wire-frames and user stories.

Finally the execution of this app should happen in phases, phases should correspond roughly to pages or major feature areas. I'll leave it to you to declare the number of phases and what their independent passing conditions are, but these conditions should be approved by me and allow me to provide you feedback before moving on into the next phase.

Before writing any code, please confirm your understanding of the application by summarizing the user journey and listing the pages you plan to build.
