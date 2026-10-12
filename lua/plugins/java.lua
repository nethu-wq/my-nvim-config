-- Builds on the lang.java extra (jdtls, debugging, test runner, refactor keymaps).

-- Newest installed JDK 25, so Java updates (25.0.2 -> 25.0.3) don't need a config change
local function find_jdk25()
  local dirs = {}
  for _, vendor in ipairs({ "Java", "Eclipse Adoptium", "Microsoft" }) do
    vim.list_extend(dirs, vim.fn.glob("C:/Program Files/" .. vendor .. "/jdk-25*", false, true))
  end
  dirs = vim.tbl_filter(function(dir)
    return vim.fn.executable(dir .. "/bin/java.exe") == 1
  end, dirs)
  local function version(dir)
    return vim.version.parse(vim.fs.basename(dir):gsub("^jdk%-", ""), { strict = false }) or vim.version.parse("0")
  end
  table.sort(dirs, function(a, b)
    return vim.version.gt(version(a), version(b))
  end)
  return dirs[1] and vim.fs.normalize(dirs[1])
end

local jdk25 = find_jdk25()

return {
  -- google-java-format on save, AOSP style (4-space indent)
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        java = { "google-java-format" },
      },
      formatters = {
        ["google-java-format"] = { prepend_args = { "--aosp" } },
      },
    },
  },

  {
    "mfussenegger/nvim-jdtls",
    opts = function(_, opts)
      if jdk25 then
        -- Run jdtls itself on JDK 25, and compile projects against Java 25
        table.insert(opts.cmd, "--java-executable=" .. jdk25 .. "/bin/java.exe")
        opts.settings = vim.tbl_deep_extend("force", opts.settings or {}, {
          java = {
            configuration = {
              runtimes = {
                { name = "JavaSE-25", path = jdk25, default = true },
              },
            },
          },
        })
      else
        vim.notify("No JDK 25 found under C:/Program Files; jdtls will use the default java", vim.log.levels.WARN)
      end

      opts.settings = vim.tbl_deep_extend("force", opts.settings or {}, {
        java = {
          completion = {
            -- never suggest/auto-import java.awt.List and friends
            filteredTypes = { "java.awt.*", "com.sun.*", "sun.*", "jdk.*" },
          },
        },
      })
    end,
  },

  -- java-debug on Windows never resolves breakpoints sent with forward-slash paths
  -- (C:/...), which is how the pickers/explorer name buffers; send backslashes instead
  {
    "mfussenegger/nvim-dap",
    optional = true,
    opts = function()
      if vim.fn.has("win32") == 0 then
        return
      end
      local Session = require("dap.session")
      if Session._java_backslash_paths then
        return
      end
      Session._java_backslash_paths = true
      local request = Session.request
      function Session:request(command, arguments, on_result)
        if command == "setBreakpoints" and self.config.type == "java" and arguments.source.path then
          arguments.source.path = arguments.source.path:gsub("/", "\\")
        end
        return request(self, command, arguments, on_result)
      end
    end,
  },
}
