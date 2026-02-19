return {
  "mfussenegger/nvim-dap",
  recommended = true,
  desc = "Debugging support. Requires language specific adapters to be configured. (see lang extras)",

  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
    {
      "theHamsta/nvim-dap-virtual-text",
      opts = {},
      config = function(_, opts)
        require("nvim-dap-virtual-text").setup(opts)
      end,
    },
  },

  keys = {
    { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, desc = "Breakpoint Condition" },
    { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
    { "<leader>dc", function() require("dap").continue() end, desc = "Run/Continue" },

    -- Запуск с аргументами: спросит строку args, сохранит и запустит
    {
      "<leader>da",
      function()
        local input = vim.fn.input("Args: ", vim.g.dap_cpp_args or "")
        vim.g.dap_cpp_args = input
        require("dap").continue()
      end,
      desc = "Run (set args)",
    },

    { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
    { "<leader>dg", function() require("dap").goto_() end, desc = "Go to Line (No Execute)" },
    { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
    { "<leader>dj", function() require("dap").down() end, desc = "Stack Down" },
    { "<leader>dk", function() require("dap").up() end, desc = "Stack Up" },
    { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
    { "<leader>do", function() require("dap").step_out() end, desc = "Step Out" },
    { "<leader>dO", function() require("dap").step_over() end, desc = "Step Over" },
    { "<leader>dP", function() require("dap").pause() end, desc = "Pause" },
    { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
    { "<leader>ds", function() require("dap").session() end, desc = "Session Info" },
    { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
    { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets Hover" },
  },

  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    dapui.setup()

    dap.listeners.before.attach.dapui_config = function() dapui.open() end
    dap.listeners.before.launch.dapui_config = function() dapui.open() end
    dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
    dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

    --------------------------------------------------
    -- adapter (codelldb)
    --------------------------------------------------
    dap.adapters.codelldb = {
      type = "server",
      port = "${port}",
      executable = {
        command = "codelldb",
        args = { "--port", "${port}" },
      },
    }

    --------------------------------------------------
    -- args helper
    --------------------------------------------------
    local function prompt_args()
      local args_str = vim.g.dap_cpp_args
      if not args_str or args_str == "" then
        args_str = vim.fn.input("Args: ")
        vim.g.dap_cpp_args = args_str
      end
      if args_str == "" then
        return {}
      end
      return vim.fn.split(args_str, " ", { plain = true, trimempty = true })
    end

    --------------------------------------------------
    -- configurations (C/C++)
    --------------------------------------------------
    dap.configurations.cpp = {
      {
        name = "Launch (codelldb)",
        type = "codelldb",
        request = "launch",

        program = function()
          local default = vim.fn.getcwd() .. "/"
          return vim.fn.input("Path to executable: ", default, "file")
        end,

        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        args = prompt_args,

        -- по желанию:
        -- console = "integratedTerminal",
        -- terminal = "integrated",
      },
    }

    dap.configurations.c = dap.configurations.cpp
  end,
}

