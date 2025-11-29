local function get_jdtls_paths()
    local mason_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls"
    local jdtls_bin = mason_path .. "/bin/jdtls"
    local lombok_jar = mason_path .. "/lombok.jar"

    -- 1. Check Mason first (Most reliable)
    if vim.fn.executable(jdtls_bin) == 1 then
        return jdtls_bin, lombok_jar
    end

    -- 2. Fallback to System (Linux/Mac)
    if vim.fn.executable("jdtls") == 1 then
        -- Try to find lombok in common system locations
        if vim.fn.filereadable("/usr/share/java/lombok.jar") == 1 then
            return "jdtls", "/usr/share/java/lombok.jar"
        elseif vim.fn.filereadable("/opt/homebrew/share/java/lombok.jar") == 1 then
            return "jdtls", "/opt/homebrew/share/java/lombok.jar"
        end
        return "jdtls", nil
    end

    return nil, nil
end

local jdtls_bin, lombok_path = get_jdtls_paths()

if not jdtls_bin then
    print("Error: JDTLS not found. Install via :Mason")
    return
end

-- =========================================================
-- WORKSPACE SETUP (Crucial so projects don't conflict)
-- =========================================================
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = vim.fn.stdpath('data') .. '/site/java/workspace-root/' .. project_name

-- =========================================================
-- BUILD THE COMMAND
-- =========================================================
local cmd = {
    jdtls_bin,
    '-data', workspace_dir, -- Must have this for stability
}

if lombok_path and vim.fn.filereadable(lombok_path) == 1 then
    table.insert(cmd, '--jvm-arg=-javaagent:' .. lombok_path)
end

-- =========================================================
-- START CLIENT
-- =========================================================
local config = {
    cmd = cmd,
    root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw' }, { upward = true })[1]),

    -- Simple on_attach to give you 'gd' and 'K'
    on_attach = function(client, bufnr)
        local opts = { noremap=true, silent=true, buffer=bufnr }
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
    end
}

require('jdtls').start_or_attach(config)
