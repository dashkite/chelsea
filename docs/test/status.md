# Chelsea Web Client: Test Status

## Overview
The Chelsea test suite is designed to verify the human experience (HX) and reactive integrity of the Byline application using the **Mimic** browser automation library. The suite is currently undergoing a refactor to utilize modular test cases and robust synchronization patterns.

## Test Narrative
The tests focus on the core author workflows as defined in the product requirements and the narratives defined in the [test narratives](./narrative.md):
1.  **Frictionless Authentication**: Verifying that entering an email correctly resolves or creates a profile and navigates to the dashboard.
2.  **Dashboard & Navigation**: Ensuring authors can traverse the application's primary views (Dashboard, Edit Blog, Edit Post).
3.  **Content Lifecycle**: Verifying post creation, auto-save functionality, and the publishing/deletion flow.
4.  **Blog Identity**: Testing the persistence of blog title and description updates.

## Modular Test Structure
The suite is organized into functional modules within `test/cases/`:
- `auth.coffee`: Authentication and redirection logic.
- `dashboard.coffee`: View transitions and content summaries.
- `editor.coffee`: Detailed writing environment interactions.
- `identity.coffee`: Metadata management.

## Orchestration Patterns

### Shared Browser Instance
To maximize performance, the entire suite shares a single Puppeteer browser instance. Each test case is responsible for creating and closing its own `BrowserContext` to ensure state isolation.

### `tee pipe` for Context Management
We use the `tee pipe` pattern from `@dashkite/joy/function` to perform nested interactions (e.g., entering shadow roots) without losing the original stack context. This eliminates the need for manual `K.drop` calls and makes the pipelines more readable.

### Synchronization
- **`waitForShadow`**: A custom Mimic combinator used to wait specifically for a component's `shadowRoot` to be attached.
- **Selector-based `waitFor`**: For view transitions, we wait specifically for the active page's `data-name` attribute:
  ```coffeescript
  Mimic.waitFor ".active.page[data-name='#{ name }']"
  ```
  This targets the underlying Monterey routing state directly, avoiding races with UI titles.

## Current Test Failures & Analysis

### 1. Poor Test Isolation
- **Symptom**: `Waiting for selector <selector> failed`
- **Analysis**: Amen (the test runner) runs tests in parallel by default, so tests may be interfering with each other.
- **Solution**: Refactoring the suite for better isolation by awaiting on each high-level test in the top-level test runner.

### 2. "View Posts" Rendering
- **Symptom**: The "View Posts" page appears empty or fails to render its content in some scenarios.
- **Analysis**: Potential stall in the `Posts` controller's reactor, where it might not be yielding the initial aggregate state correctly.

## Maintenance Guidelines
- **Publish Order**: When updating library modules, you must build and publish the library and then Chelsea to regenerate the application’s `importmap`.
- **Descriptive Selectors**: Favor `data-name` attributes and part names over fragile CSS paths.
