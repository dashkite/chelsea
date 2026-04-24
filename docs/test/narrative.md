# Test Narrative

This narrative outlines the actions supported by the Chelsea Web client to satisfy the [product requirements][]. This narrative forms the basis for the test [actions][] and [scenarios][].

## Connecting

### Connecting
**Base Flow**: This flow describes the shared interaction for connecting to the application.

#### Actions
1. Navigate to the [connect][] page.
2. Wait for the `email-connector` component.
3. Select the `form-field` component, enter its shadow root, and type the email into the `input`.
4. Select the connect `button` and click it.

### Connecting (New Creator)
**Scenario**: A new author signs in for the first time.

#### Context
The system contains no profile or blog resource for the provided email.

#### Actions
1. Complete [connecting][].

#### Expectations
- Confirm that `localStorage` contains a `connection` key.
- Confirm that the active view is [posts view][].
- Confirm that a new blog address is generated and associated with the profile.

### Connecting (Returning Creator)
**Scenario**: An existing author signs in again.

#### Context
The system already contains a profile and a blog address for the provided email.

#### Actions
1. Complete [connecting][].

#### Expectations
- Confirm that `localStorage` contains a `connection` key.
- Confirm that the active view is [posts view][].
- Confirm that the existing blog address is resolved and the profile is correctly loaded.

## Managing The Blog

### Editing The Blog
**Scenario**: An author updates their blog's metadata.

#### Actions
1. Complete [connecting (new creator)][].
2. Wait for the `posts-view` component.
3. Select the link to [blog edit][] and click it.
4. Select the `blog-editor` component and enter its shadow root.
5. Update the title and description inputs.

#### Expectations
- Confirm that the new title and description are correctly saved to the blog resource.

## Posting

### Viewing Posts
**Scenario**: An authenticated author returns to their post list.

#### Actions
1. Complete [connecting (new creator)][].
2. Select the link to [posts view][] and click it.

#### Expectations
- Confirm that the active view is [posts view][].

### Creating A Post
**Scenario**: An author starts a new post.

#### Actions
1. Complete [connecting (new creator)][] to reach [posts view][].
2. Select the `posts-view` component and enter its shadow root.
3. Select the `button[name='add post']` element and click it.

#### Expectations
- Confirm that the active view is [post edit][] for a new, unique post resource.

### Writing A Post
**Scenario**: An author writes and publishes a post.

#### Actions
1. Complete [creating a post][].
2. Select the `post-editor` component and enter its shadow root.
3. Type Markdown content into the editor input.
4. Use the `post-actions` panel to "Publish" the post.

#### Expectations
- Confirm that typing triggers an update to the stored post state.
- Confirm that publishing updates the post's status.

### Deleting A Post
**Scenario**: An author deletes a post.

#### Actions
1. Complete [writing a post][].
2. Use the `post-actions` panel to "Remove" the post.

#### Expectations
- Confirm that deleting the post redirects the author back to the [posts view][] page and removes the post from storage.

[connect]: #connecting
[connecting]: #connecting-1
[connecting (new creator)]: #connecting-new-creator
[connecting (returning creator)]: #connecting-returning-creator
[editing the blog]: #editing-the-blog
[viewing posts]: #viewing-posts
[creating a post]: #creating-a-post
[writing a post]: #writing-a-post
[blog edit]: #editing-the-blog
[posts view]: #viewing-posts
[post edit]: #creating-a-post
[product requirements]: https://github.com/dashkite/central-park/blob/main/.meta/docs/product-requirements.md
[actions]: ../../test/actions.coffee
[scenarios]: ../../test/scenarios/data.yaml
