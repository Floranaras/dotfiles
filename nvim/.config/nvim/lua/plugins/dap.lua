--- @file dap.lua
--- @brief Debug Adapter Protocol (DAP) configuration and UI integration.
--- This module configures debugging for C/C++, JavaScript, and TypeScript,
--- providing automated UI management and standardized keybindings.

return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
    },
    --- @brief Initializes DAP adapters, configurations, and UI listeners.
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      -- Initialize the debugging UI
      dapui.setup()

      -- =======================================================================
      -- 1. UI AUTOMATION
      -- =======================================================================

      -- Automatically open/close DAP UI when sessions start or end.
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      -- =======================================================================
      -- 2. KEYBINDINGS
      -- =======================================================================

      vim.keymap.set("n", "<F5>", dap.continue)
      vim.keymap.set("n", "<F10>", dap.step_over)
      vim.keymap.set("n", "<F11>", dap.step_into)
      vim.keymap.set("n", "<F12>", dap.step_out)
      vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint)

      -- Set conditional breakpoint with user input
      vim.keymap.set("n", "<leader>B", function()
        dap.set_breakpoint(vim.fn.input("Condition: "))
      end)

      -- =======================================================================
      -- 3. VISUALS (SIGNS)
      -- =======================================================================

      vim.fn.sign_define("DapBreakpoint", {
        text = "●",
        texthl = "ErrorMsg",
      })
      vim.fn.sign_define("DapStopped", {
        text = "→",
        texthl = "String",
      })

      -- =======================================================================
      -- 4. ADAPTER: C / C++ (codelldb)
      -- =======================================================================

      local codelldb_path = vim.fn.stdpath("data") .. "/mason/bin/codelldb"

      dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
          command = codelldb_path,
          args = { "--port", "${port}" },
        },
      }

      dap.configurations.c = {
        {
          name = "Launch",
          type = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input(
              "Executable: ",
              vim.fn.getcwd() .. "/",
              "file"
            )
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
        },
      }

      -- Reuse C configuration for C++
      dap.configurations.cpp = dap.configurations.c

      -- =======================================================================
      -- 5. ADAPTER: JAVASCRIPT / TYPESCRIPT (js-debug-adapter)
      -- =======================================================================

      local js_path = vim.fn.stdpath("data")
        .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js"

      dap.adapters["pwa-node"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = "node",
          args = { js_path, "${port}" },
        },
      }

      local js_config = {
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          cwd = "${workspaceFolder}",
        },
      }

      -- Apply shared JS config to related filetypes
      dap.configurations.javascript = js_config
      dap.configurations.typescript = js_config
      dap.configurations.javascriptreact = js_config
      dap.configurations.typescriptreact = js_config
    end,
  },
}
