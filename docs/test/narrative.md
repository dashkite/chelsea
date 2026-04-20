# Test Narrative: Chelsea Web Client (Byline)

This narrative outlines the user-centric flows we will verify to ensure the Chelsea Web Client fulfills its product requirements.

## 1. Authentication Flow (Frictionless Auth)
**Scenario**: A new author signs in for the first time.
- **Actions**:
  1. Navigate to the login page.
  2. Locate the `email-connector` component.
  3. Enter a valid email into the `form-field` input.
  4. Click the connect button.
- **Expectations**:
  - `localStorage` contains the user's connection state.
  - The author is redirected to the Dashboard ("View Posts").
  - The page displays an `<h1>` with the text "View Posts".

## 2. Dashboard & Navigation
**Scenario**: An authenticated author explores their content.
- **Actions**:
  1. Complete the Authentication Flow.
  2. Verify the presence of the `posts-view` component.
  3. Use the global navigation to switch to "Edit Blog".
- **Expectations**:
  - Navigating to "Edit Blog" displays an `<h1>` with "Edit Blog".
  - The URL reflects the current view.

## 3. Blog Identity Management
**Scenario**: An author updates their blog's metadata.
- **Actions**:
  1. Navigate to "Edit Blog".
  2. Update the blog title and description fields.
  3. Verify persistence via `localStorage` or page refresh.
- **Expectations**:
  - New title and description are correctly saved.

## 4. Content Creation & Redirection
**Scenario**: An author starts a new post.
- **Actions**:
  1. Navigate to the Dashboard.
  2. Click the "Add Post" button within `posts-view`.
- **Expectations**:
  - The author is instantly redirected to the "Edit Post" view.
  - The URL contains a new unique post ID (e.g., `/post/xyz123`).

## 5. Writing & Post Lifecycle
**Scenario**: An author writes, publishes, and eventually deletes a post.
- **Actions**:
  1. Create a new post.
  2. Type Markdown content into the editor.
  3. Verify "Auto-Save" (check `localStorage` after typing).
  4. Use the `post-actions` panel to "Publish" the post.
  5. Use the `post-actions` panel to "Remove" the post.
- **Expectations**:
  - Typing triggers an update to the stored post state.
  - Publishing updates the post's status.
  - Deleting redirects the author back to the Dashboard and removes the post from storage.
