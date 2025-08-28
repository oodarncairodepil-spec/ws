# Database Management for Whiteout Survival Companion App

## Overview

This directory contains database scripts for the Whiteout Survival companion app. The database structure is designed to separate schema setup from data updates to prevent overwriting user data.

## File Structure

```
database/
├── setup.sql              # Initial schema and reference data setup
├── migrations/             # Data updates and schema changes
│   └── 001_add_fire_crystal_furnace.sql
└── README.md              # This file
```

## Database Setup Strategy

### 1. Initial Setup (`setup.sql`)

**Purpose**: Creates tables, indexes, policies, and inserts reference data

**When to run**: 
- First time setting up the database
- When creating a fresh database instance

**What it contains**:
- Table definitions
- Indexes and constraints
- RLS (Row Level Security) policies
- Reference data (buildings, resources, heroes, etc.)
- Initial building level data

**Important**: This script uses `ON CONFLICT DO NOTHING` to prevent overwriting existing data.

### 2. Migration Scripts (`migrations/`)

**Purpose**: Add new features, update reference data, or modify schema

**When to run**: 
- When adding new building types (like Fire Crystal Furnace)
- When updating game data after patches
- When adding new features to the app

**Naming Convention**: `XXX_description.sql` (e.g., `001_add_fire_crystal_furnace.sql`)

## How to Use

### First Time Setup

1. Run `setup.sql` in your Supabase SQL editor
2. This creates all tables and populates reference data

### Adding New Data (like Fire Crystal Furnace)

1. Run the appropriate migration script (e.g., `001_add_fire_crystal_furnace.sql`)
2. This adds new building data without affecting existing user data

### Why This Approach?

**Problem**: Running the full `setup.sql` again would:
- Potentially overwrite user data
- Reset player progress
- Cause conflicts with existing policies

**Solution**: Separate migrations allow:
- Safe updates to reference data
- Preservation of user data
- Incremental database changes
- Better version control

## Migration Script Guidelines

1. **Always use `ON CONFLICT DO NOTHING`** for reference data
2. **Use `IF NOT EXISTS`** for schema changes
3. **Include rollback instructions** in comments
4. **Test on a copy** before running on production
5. **Document what the migration does** in comments

## Current Migrations

- `001_add_fire_crystal_furnace.sql`: Adds Fire Crystal Furnace building data with levels 31-35

## User Data Safety

The following tables contain user data and should NEVER be truncated or reset:
- `players`
- `game_states` 
- `strategies`

Reference tables that can be safely updated:
- `buildings`
- `building_levels`
- `resources`
- `heroes`
- `hero_upgrade_costs`