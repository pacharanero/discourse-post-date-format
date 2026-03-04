# discourse-post-date-format

Theme component for Discourse that always shows a full, absolute date/time for post timestamps instead of relative strings like "4 days ago".

## Features

- Replaces the default post timestamp display with a full date/time (for example: `18 December 2025, 14:32`).
- Works regardless of the core `relative_date_duration` site setting.
- Keeps the existing post date link behaviour (clicking the date still opens the share dialog).

## Installation

1. In your Discourse instance, go to **Admin → Customize → Themes**.
2. Choose **Install** → **From a git repository**.
3. Enter this theme component's repository URL.
4. After installation, ensure this theme component is **enabled** and associated with the desired themes.

## Configuration

- Core setting: `relative_date_duration`
  - If this is greater than `0`, Discourse normally shows relative dates ("4 days ago").
  - If this is `0`, Discourse core stops using relative dates.
- This theme component overrides the post timestamp rendering so that post dates are always shown as full dates, even when `relative_date_duration` is non‑zero.

- Theme component setting: `post_timestamp_editor_allowed_groups`
	- Comma-separated group names allowed to edit post timestamps in addition to admins.
	- Default is empty, which means **admins only**.
	- UI allowlist for showing/enabling timestamp-edit controls in addition to admins.
	- Empty means admins only (UI).
	- Note: Discourse core server-side permissions still apply. Core only exposes a **topic timestamp shift** endpoint (staff-only). Allowing non-staff groups and/or true per-post reordering requires a plugin.

## How to Test

1. **Prepare the site setting**
	- Go to **Admin → Settings → Default Language & Locale** (or search for `relative_date_duration`).
	- Set `relative_date_duration` to a non‑zero value (for example: `14`) so that core would normally show relative dates.

2. **Create or use an existing topic**
	- Open any topic and look at the small timestamp next to the poster name on each post.

3. **Verify behaviour with the theme component enabled**
	- Confirm that each post's timestamp shows a full date/time (for example: `18 December 2025, 14:32`) instead of a relative string like `4 days ago`.
	- Hover/focus behaviour and clicking the timestamp should still open the standard share modal.

4. **Optional: compare with the component disabled**
	- Temporarily disable this theme component for your theme.
	- Reload the same topic and check that post timestamps revert to the default behaviour (usually relative dates when `relative_date_duration` is non‑zero).

If the behaviour matches the steps above, the theme component is working as intended.
