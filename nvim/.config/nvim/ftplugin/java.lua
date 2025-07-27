-- Cross-platform Java configuration for macOS and Linux
local function get_jdtls_cmd()
    local uname = vim.loop.os_uname()

    if uname.sysname == "Darwin" then
        -- macOS (Homebrew)
        local homebrew_path = "/opt/homebrew/opt/jdtls/bin/jdtls"
        if vim.fn.executable(homebrew_path) == 1 then
            return { homebrew_path }
        end
    elseif uname.sysname == "Linux" then
        -- Linux (try system installation first)
        if vim.fn.executable("/usr/bin/jdtls") == 1 then
            return { "/usr/bin/jdtls" }
        end
    end

    -- Fallback to Mason (works on all platforms)
    local mason_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls/bin/jdtls"
    if vim.fn.executable(mason_path) == 1 then
        return { mason_path }
    end

    -- Last resort - hope it's in PATH
    if vim.fn.executable("jdtls") == 1 then
        return { "jdtls" }
    end

    return nil
end

local jdtls_cmd = get_jdtls_cmd()
if jdtls_cmd then
    local config = {
        cmd = jdtls_cmd,
        root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1]),
    }
    require("jdtls").start_or_attach(config)
else
    local uname = vim.loop.os_uname()
    if uname.sysname == "Darwin" then
        print("jdtls not found. Install with: brew install jdtls")
    elseif uname.sysname == "Linux" then
        print("jdtls not found. Install with: yay -S jdtls  OR  :Mason -> install jdtls")
    else
        print("jdtls not found. Install via :Mason -> search jdtls -> install")
    end
end
