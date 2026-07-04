# Discourse Date Format Theme Component

This Discourse theme component allows you to customize the date format displayed in posts.

## Goal

- Provide flexible options for displaying post timestamps in various formats
- Allow users to hide post dates entirely if desired
- Maintain compatibility with Discourse's existing date handling while providing customization options

## Supported Date Format Options

1. **Full Format** - Complete date/time display (e.g., "18 December 2025, 14:32")
2. **Short Format** - Condensed date display (e.g., "Dec 18, 2025")
3. **Custom Format** - User-defined format using Moment.js syntax
4. **None** - Hide post dates entirely

## Implementation Approach

The theme component will:

1. Override the default post date display component
2. Read the theme settings to determine the desired format
3. Apply the appropriate formatting based on user preferences
4. Maintain existing functionality (click to share, etc.)

## Dependencies

- Discourse core `relative_date_duration` setting must be set to `0`
- Uses Discourse's built-in date formatting helpers where possible
- Falls back to Moment.js for custom formatting options

## Non-Goals

- This component will not modify how dates are stored or handled server-side
- Will not provide editing capabilities for post timestamps
- Will not affect other date displays in Discourse outside of post metadata