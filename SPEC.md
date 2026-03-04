# Discourse Date Format Theme Component

This Discourse theme component allows you to customize the date format displayed in posts.

Initially it just changes the default date format to a more readable format, but you can modify the code to suit your preferences.

## Goal

- Always display the full date/time for post timestamps (e.g. `18 December 2025, 14:32`) instead of short or relative forms.
- Apply this formatting consistently wherever a post's created/updated DateTime is shown in the UI.

## Existing Core Behaviour

By default, Discourse may render dates in a relative form (e.g. "4 days ago", "3 hours ago") instead of showing the full absolute date.

There is a core site setting named **`relative_date_duration`** that controls how long dates are rendered in this relative style:

- When `relative_date_duration` is greater than `0`, recent dates are shown as relative (e.g. "4 days ago").
- When `relative_date_duration` is set to `0`, Discourse core stops using relative dates and shows absolute dates instead.

## Interaction With This Theme Component

- This theme component assumes that the site setting `relative_date_duration` may already be configured by the site admin.
- If `relative_date_duration` is set to `0`, the component builds on top of that behaviour, ensuring that post DateTime values are always presented in a clear, full-date format.
- If `relative_date_duration` is non-zero, the component's implementation must still ensure that post timestamps appear as full dates (rather than relative strings) wherever it hooks into the UI.

## Post Timestamp Editing (Reordering Posts)

### Summary

This theme component may expose a UI affordance to adjust timestamps from the topic view.

Important constraint: **Discourse renders post order by `post_number`, not by `created_at`**. Changing a post's displayed timestamp alone does not inherently reorder it in the stream.

Discourse core includes a **topic timestamp** changer which shifts the timestamps of the topic and its posts together. True **per-post timestamp editing that reorders posts within a topic** requires server-side support (typically a plugin), because it must change ordering/numbering on the backend.

### User Experience

- The timestamp area can be used to open an **Edit timestamp** interface.
- The interface allows selecting a new date/time.
- On successful change:
	- the timestamp display updates to the new value
	- if the underlying implementation changes ordering on the backend, the post may move within the topic
	- the UI should clearly reflect completion (e.g. modal closes and/or the topic view refreshes)
- The existing click behaviour (opening share) must remain available; the timestamp editing affordance must not remove the share capability.

### Back-end Behaviours

Two backend behaviours are in scope, but they have different feasibility:

1. **Core-supported topic timestamp shift (theme-only feasible)**
	 - Uses Discourse core's topic timestamp changer endpoint (`PUT /t/:id/change-timestamp.json`) and associated UI patterns.
	 - Effect: shifts the topic's timestamp and adjusts post timestamps relative to the new topic timestamp.
	 - Effect on ordering: **does not reorder posts within a topic** (post numbers remain the ordering key).

2. **Per-post timestamp editing with stream reordering (plugin required)**
	 - Requires a server-side API to update a specific post's effective ordering (typically by renumbering/reordering within the topic).
	 - A theme component can provide UI, but cannot implement the backend logic or authorization.

### Permissions

- Discourse core enforces permissions server-side.
- For the **core topic timestamp shift** endpoint, permission is **staff** (admins/moderators) via `guardian.ensure_can_change_post_timestamps!`.
- If the desired policy is **admins only** or **admins plus selected groups**, that cannot be enforced purely by a theme component. A theme can hide the UI, but **a plugin is required** to enforce non-core authorization rules.

### Theme Component Setting

- Setting key: `post_timestamp_editor_allowed_groups`
- Type: group list (or a comma-separated list of group names, depending on theme settings capabilities)
- Default: empty (meaning **Admins only** at the UI layer)
- Behaviour:
	- If the current user is an admin, show/enable the edit timestamp UI.
	- Else if the current user is in any group listed in `post_timestamp_editor_allowed_groups`, show/enable the edit timestamp UI.
	- Otherwise, hide/disable the edit timestamp UI.

Note: this setting can only control visibility/enabled state in the client. Server-side permission checks still apply.

### Non-Goals

- This feature does not attempt to redefine Discourse's server-side authorization model; it must rely on Discourse core endpoints and permissions.
- This feature does not change how post timestamps are stored; it only provides a UI to request the change.