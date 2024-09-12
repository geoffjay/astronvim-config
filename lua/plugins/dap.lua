---@type LazySpec
return {
  "mfussenegger/nvim-dap",
  optional = true,
  dependencies = {
    "suketa/nvim-dap-ruby",
  },
  config = function()
    local dap = require "dap"
    if not dap.adapters["pwa-node"] then
      dap.adapters["pwa-node"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = "node",
          args = {
            require("mason-registry").get_package("js-debug-adapter"):get_install_path()
              .. "/js-debug/src/dapDebugServer.js",
            "${port}",
          },
        },
      }
    end
    if not dap.adapters.node then
      dap.adapters.node = function(cb, config)
        if config.type == "node" then config.type = "pwa-node" end
        local pwa_adapter = dap.adapters["pwa-node"]
        if type(pwa_adapter) == "function" then
          pwa_adapter(cb, config)
        else
          cb(pwa_adapter)
        end
      end
    end

    -- dap.adapters.ruby = {
    --   type = "executable",
    --   command = "bundle",
    --   -- args = { "exec", "rdbg", "--", "bundle", "exec", "ruby" },
    --   args = { "exec", "rdbg", "-A" },
    --   name = "ruby",
    -- }

    -- dap.adapters.ruby = function(callback)
    --   vim.ui.select(vim.fn.readdir "/tmp/ruby-debug", { prompt = "Select socket" }, function(pipe)
    --     if not pipe then return end
    --
    --     callback {
    --       type = "pipe",
    --       pipe = "/tmp/ruby-debug/" .. pipe,
    --     }
    --   end)
    -- end

    -- dap.adapters.ruby = function(callback, _config)
    --   callback {
    --     type = "executable",
    --     executable = {
    --       command = "bundle",
    --       args = { "exec", "rdbg", "-n", "-c", "-A" },
    --     },
    --   }
    -- end

    dap.adapters.ruby = function(callback, config)
      callback {
        type = "server",
        host = "127.0.0.1",
        port = "${port}",
        executable = {
          command = "bundle",
          args = {
            "exec",
            "rdbg",
            -- "-n",
            -- "--open",
            -- "--port",
            -- "${port}",
            -- "-c",
            -- "--",
            -- "bundle",
            -- "exec",
            -- config.command,
            -- config.script,
          },
        },
      }
    end

    local js_filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact" }
    local js_config = {
      {
        type = "pwa-node",
        request = "launch",
        name = "Launch file",
        program = "${file}",
        cwd = "${workspaceFolder}",
      },
      {
        type = "pwa-node",
        request = "attach",
        name = "Attach",
        processId = require("dap.utils").pick_process,
        cwd = "${workspaceFolder}",
      },
    }

    for _, language in ipairs(js_filetypes) do
      if not dap.configurations[language] then dap.configurations[language] = js_config end
    end

    local rb_filetypes = { "ruby" }
    local rb_config = {
      {
        type = "ruby",
        request = "launch",
        name = "Launch file",
        program = "${file}",
        cwd = "${workspaceFolder}",
      },
      {
        type = "ruby",
        request = "attach",
        name = "Attach debugger",
        cwd = "${workspaceFolder}",
      },
      {
        type = "ruby",
        request = "launch",
        name = "Debug test",
        cwd = "${workspaceFolder}",
        program = "bundle exec ruby -Itest ${relativeFile}",
      },
    }

    for _, language in ipairs(rb_filetypes) do
      if not dap.configurations[language] then dap.configurations[language] = rb_config end
    end

    local vscode_filetypes = require("dap.ext.vscode").type_to_filetypes
    vscode_filetypes["node"] = js_filetypes
    vscode_filetypes["pwa-node"] = js_filetypes
    vscode_filetypes["ruby"] = rb_filetypes

    if vim.fn.filereadable ".vscode/launch.json" then require("dap.ext.vscode").load_launchjs() end
  end,
}
