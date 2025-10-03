# Neovim Database Management Guide

Complete reference for working with databases in Neovim using vim-dadbod and vim-dadbod-ui.

## Installation

The plugins are already configured in your `lua/plugins/dadbod.lua` file. They will be automatically installed by lazy.nvim on next startup.

## Setup

### Adding a Database Connection

1. Open the database UI:
   ```
   <leader>db
   ```

2. Press `A` to add a new connection

3. Enter your connection string:
   ```
   mysql://root:password@localhost/database_name
   ```

4. Give the connection a name when prompted

### Connection String Formats

**MySQL:**
```
mysql://username:password@localhost/database_name
mysql://username:password@localhost:3306/database_name
mysql://root@localhost/dbworld
```

**PostgreSQL:**
```
postgresql://username:password@localhost/database_name
postgresql://username:password@localhost:5432/database_name
```

**SQLite:**
```
sqlite:///path/to/database.db
sqlite://~/projects/myapp.db
```

## Key Bindings

### Database UI Commands

| Key | Action |
|-----|--------|
| `<leader>db` | Toggle Database UI |
| `<leader>df` | Find database buffer |
| `<leader>dr` | Rename database buffer |
| `<leader>dq` | Show last query info |

### DBUI Sidebar Navigation

| Key | Action |
|-----|--------|
| `<CR>` | Open/execute item under cursor |
| `S` | Execute SELECT * on table |
| `C` | Execute COUNT on table |
| `W` | Create new query buffer |
| `R` | Refresh/redraw UI |
| `d` | Delete saved query |
| `r` | Rename saved query |
| `A` | Add new database connection |
| `q` | Close DBUI window |

### Query Execution

| Key | Mode | Action |
|-----|------|--------|
| `<leader>S` | Normal | Execute entire buffer/query |
| `<leader>S` | Visual | Execute selected SQL |

## Working with Queries

### Creating and Running Queries

1. In DBUI sidebar, navigate to a database or saved queries
2. Press `W` to create a new query buffer
3. Write your SQL:
   ```sql
   SELECT * FROM users WHERE active = 1;
   ```
4. Press `<leader>S` to execute

### Executing Part of a Query

1. Write multiple queries in a buffer:
   ```sql
   SELECT COUNT(*) FROM users;
   SELECT * FROM users LIMIT 10;
   SELECT * FROM orders WHERE user_id = 5;
   ```
2. Visually select the query you want to run (`V` for line selection)
3. Press `<leader>S` to execute only the selected query

### Viewing Results

- Results appear automatically in a split below
- Line numbers show the total row count
- Results are read-only (scroll with `j/k` or `Ctrl-d/Ctrl-u`)

### Saving Queries

Queries are automatically saved to: `~/.local/share/nvim/db_ui/`

## Window Management

### Resizing Windows

| Key | Action |
|-----|--------|
| `Ctrl + Left` | Decrease window width |
| `Ctrl + Right` | Increase window width |
| `Ctrl + Up` | Increase window height |
| `Ctrl + Down` | Decrease window height |

### Navigating Between Windows

| Key | Action |
|-----|--------|
| `Ctrl + h` | Move to left window |
| `Ctrl + l` | Move to right window |
| `Ctrl + j` | Move to window below |
| `Ctrl + k` | Move to window above |

### Window Quick Actions

| Key | Action |
|-----|--------|
| `<leader>we` | Equalize all window sizes |
| `<leader>wm` | Maximize current window |
| `<leader>wc` | Close current window |
| `<leader>wo` | Close all other windows |

## Configuration

The configuration is located in `lua/plugins/dadbod.lua` with the following settings:

- **UI Position**: Left sidebar
- **Window Width**: 40 columns
- **Nerd Fonts**: Enabled for icons
- **Auto-execute**: Disabled (manual execution with `<leader>S`)
- **Fold Results**: Disabled (results show immediately)
- **Line Numbers**: Enabled in result buffers

## Tips and Tricks

### Viewing Row Count

The line number at the bottom of the result buffer shows your total row count.

### Quick Table Actions

Navigate to any table in DBUI and:
- Press `S` for quick SELECT *
- Press `C` for COUNT(*)

### Multiple Databases

You can add multiple connections for different databases or servers. Each will appear in the DBUI sidebar.

### SQL Autocompletion

When editing SQL files, nvim-cmp provides:
- Table name completion
- Column name completion
- SQL keyword completion

Start typing and use:
- `Ctrl-n` / `Ctrl-p` to navigate suggestions
- `Ctrl-y` or `Enter` to confirm

### Checking Query Execution Time

After running a query, type `:messages` to see execution time and any warnings.

## Troubleshooting

### Connection Issues

If you see connection errors:
1. Verify your database is running
2. Check username/password in connection string
3. Ensure the database exists
4. Try connecting via command line first: `mysql -u root -p`

### Password Warning

The MySQL warning about passwords on command line is normal and can be ignored. The query still executes successfully.

### Cannot Make Changes Error

If you see "E21: Cannot make changes, 'modifiable' is off", this is normal. Result buffers are read-only by design.

## Common Workflows

### Exploring a Database

1. Open DBUI: `<leader>db`
2. Navigate to your database connection
3. Expand tables with `<CR>`
4. Press `S` on a table to view contents
5. Press `C` on a table to see row count

### Running Ad-hoc Queries

1. Press `W` in DBUI to create a new query
2. Write your SQL
3. Execute with `<leader>S`
4. Review results in split below

### Developing Complex Queries

1. Create a `.sql` file or use DBUI query buffer
2. Write your query with multiple CTEs or joins
3. Visually select and test portions with `<leader>S`
4. Iterate until complete
5. Execute final query

### Comparing Results

1. Execute first query: `<leader>S`
2. Keep results window open
3. Navigate back to query window: `Ctrl-k`
4. Modify query
5. Execute again: `<leader>S`
6. Compare results in split windows
