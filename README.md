# discourse-post-date-format

Theme component for Discourse that allows custom formatting of post timestamps.

## Features

- Choose from predefined date formats or create your own custom format
- Option to hide post dates entirely
- Works regardless of the core `relative_date_duration` site setting
- Keeps the existing post date link behaviour (clicking the date still opens the share dialog)

## Installation

1. In your Discourse instance, go to **Admin → Customize → Themes**.
2. Choose **Install** → **From a git repository**.
3. Enter this theme component's repository URL.
4. After installation, ensure this theme component is **enabled** and associated with the desired themes.

## Configuration

This theme component provides several options for customizing how post dates are displayed:

### Theme Component Settings

1. **Date Format Option** - Choose from:
   - `full` - Complete date/time (e.g., "18 December 2025, 14:32")
   - `short` - Condensed format (e.g., "Dec 18, 2025")
   - `custom` - Use your own format (configured in the next setting)
   - `none` - Hide post dates entirely

2. **Custom Date Format** - Define your own date format using Moment.js syntax (only applies when Date Format Option is set to "custom")
   - Examples: `DD/MM/YYYY`, `MMMM Do YYYY`, `DD-MM-YYYY HH:mm`

### Important Core Setting

**You must set `relative_date_duration` to `0` for this theme component to work properly.**

- **What it does**: This core setting controls whether Discourse shows relative dates ("4 days ago") or absolute dates.
- **Why it's needed**: Even though this theme component overrides date display, it works best when Discourse isn't trying to convert dates to relative format in the background.
- **Where to find it**: Admin → Settings → Default Language & Locale → `relative_date_duration`
- **What to set it to**: `0` (zero)

## How to Test

1. **Set the core site setting**
   - Go to **Admin → Settings → Default Language & Locale** (or search for `relative_date_duration`).
   - Set `relative_date_duration` to `0`.

2. **Configure the theme component**
   - Go to **Admin → Customize → Themes**.
   - Find this theme component and click the settings icon.
   - Choose your preferred date format option.
   - If using "custom", enter your preferred format string.

3. **Create or use an existing topic**
   - Open any topic and look at the small timestamp next to the poster name on each post.

4. **Verify the behavior**
   - Confirm that each post's timestamp shows in your chosen format.
   - Hover/focus behavior and clicking the timestamp should still open the standard share modal.

If the behavior matches the steps above, the theme component is working as intended.