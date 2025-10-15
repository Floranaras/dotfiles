return {
    "nvim-lua/plenary.nvim",
    config = function()
        -- Define the Javadoc generation function
        local function create_javadoc()
            -- Get the current line
            local cursor_line = vim.api.nvim_win_get_cursor(0)[1]
            local code_line = vim.api.nvim_buf_get_lines(0, cursor_line - 1, cursor_line, false)[1] or ""

            -- Check if the line contains the start of a method or class definition
            local is_method_start = code_line:match("%(") ~= nil
            local is_class = code_line:match("class%s+[%w_]+") ~= nil or 
            code_line:match("interface%s+[%w_]+") ~= nil or 
            code_line:match("enum%s+[%w_]+") ~= nil

            -- Handle multi-line method declarations
            local full_method = code_line
            local line_count = 1
            local max_search = 15 -- Maximum lines to search for closing parenthesis

            if is_method_start and not code_line:match("%)") then
                -- Multi-line method - collect all lines until we find the closing parenthesis
                local i = 1
                while i < max_search do
                    local next_line_num = cursor_line - 1 + i
                    if next_line_num >= vim.api.nvim_buf_line_count(0) then break end

                    local next_line = vim.api.nvim_buf_get_lines(0, next_line_num, next_line_num + 1, false)[1] or ""
                    full_method = full_method .. " " .. next_line:gsub("^%s*", "")

                    if next_line:match("%)") then
                        line_count = i
                        break
                    end
                    i = i + 1
                end
            end

            -- If we couldn't find a method or class, report and exit
            if not (is_method_start or is_class) then
                vim.notify("No method or class found on current line", vim.log.levels.WARN)
                return
            end

            -- Extract indentation
            local indent = code_line:match("^%s*") or ""

            -- Create Javadoc structure
            local javadoc = { indent .. "/**" }

            if is_method_start then
                -- Extract method name
                local method_name = code_line:match("[%w_]+%s*%(")
                if method_name then
                    method_name = method_name:match("([%w_]+)%s*%(") -- Remove trailing spaces and parenthesis
                    table.insert(javadoc, indent .. " * " .. method_name)
                else
                    table.insert(javadoc, indent .. " * ")
                end

                table.insert(javadoc, indent .. " * ")

                -- Extract parameters from the full method (handling multi-line)
                local params_str = full_method:match("%((.-)%)") or ""
                if params_str ~= "" then
                    -- Clean up the params string - remove line breaks and extra spaces
                    params_str = params_str:gsub("\n", " "):gsub("%s+", " ")

                    for param in params_str:gmatch("[^,]+") do
                        -- Improved param extraction with more robust pattern matching
                        local param_type, param_name = param:match("([%w_.<>%[%]]+)%s+([%w_]+)%s*$")
                        if param_name then
                            -- Remove any extra spaces from param_name
                            param_name = param_name:gsub("%s+", "")
                            table.insert(javadoc, indent .. " * @param " .. param_name)
                        end
                    end
                end

                -- Check for return type - handles constructors and void methods
                if not full_method:match("void%s+[%w_]+%s*%(") and 
                    not full_method:match("^%s*[%w_]+%(") and -- Not a constructor
                    not full_method:match("^%s*public%s+[%w_]+%(") and -- Not a constructor with public
                    not full_method:match("^%s*private%s+[%w_]+%(") and -- Not a constructor with private
                    not full_method:match("^%s*protected%s+[%w_]+%(") then -- Not a constructor with protected
                    table.insert(javadoc, indent .. " * @return")
                end
            else
                -- Class/interface/enum documentation
                local type_name = code_line:match("class%s+([%w_]+)") or 
                code_line:match("interface%s+([%w_]+)") or 
                code_line:match("enum%s+([%w_]+)")

                if type_name then
                    table.insert(javadoc, indent .. " * " .. type_name)
                    table.insert(javadoc, indent .. " * ")
                    table.insert(javadoc, indent .. " * @author " .. (os.getenv("USER") or vim.fn.expand("$USER") or "developer"))
                    table.insert(javadoc, indent .. " * @version 1.0")
                else
                    table.insert(javadoc, indent .. " * ")
                end
            end

            -- Close the Javadoc
            table.insert(javadoc, indent .. " */")

            -- Insert the Javadoc above the current line
            vim.api.nvim_buf_set_lines(0, cursor_line - 1, cursor_line - 1, false, javadoc)

            -- Position the cursor on the method line (return to normal mode)
            vim.api.nvim_win_set_cursor(0, {cursor_line + #javadoc - 1, 0})
            -- Don't enter insert mode
            -- vim.cmd("startinsert!")
        end

        -- Create an autocmd to set up keybindings for Java files
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "java",
            callback = function()
                -- Keybinding for generating Javadoc
                vim.keymap.set("n", "<leader>jd", create_javadoc, { buffer = true, desc = "Generate Javadoc" })

                -- Auto-insert Javadoc when typing /**<CR>
                vim.keymap.set("i", "/**<CR>", function()
                    -- Get the cursor position
                    local cursor_line = vim.api.nvim_win_get_cursor(0)[1]
                    -- Check if there's a next line
                    if cursor_line < vim.api.nvim_buf_line_count(0) then
                        -- Get the next line
                        local next_line = vim.api.nvim_buf_get_lines(0, cursor_line, cursor_line + 1, false)[1] or ""
                        -- Extract indentation
                        local indent = next_line:match("^%s*") or ""
                        -- Check if next line is a method or class declaration
                        if next_line:match("public") or next_line:match("private") or 
                            next_line:match("protected") or next_line:match("class") or
                            next_line:match("interface") or next_line:match("enum") then
                            -- Return the Javadoc template
                            return "/**\n" .. indent .. " * \n" .. indent .. " */\n" .. indent
                        end
                    end
                    -- Default template for other cases
                    return "/**\n * \n */"
                end, { buffer = true, expr = true })

                -- Add a command to generate Javadoc
                vim.api.nvim_create_user_command("JavaDoc", create_javadoc, {})
            end,
        })
    end
}
