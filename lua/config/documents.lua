-- Open binary documents as read-only text:
--   .pdf                -> pdftotext (ships with Git for Windows)
--   .docx / .pptx / .odt -> pandoc, shown as markdown
-- <leader>fo (in keymaps.lua) opens the real file in its default app.
-- Loaded from init.lua (not autocmds.lua, which runs on VeryLazy -- too late for `nvim file.pdf`).

-- Find a tool on PATH, or at a known install location (new installs and
-- Git's bundled tools often aren't on the PATH nvim was started with)
local function find_exe(name, fallbacks)
  if vim.fn.executable(name) == 1 then
    return name
  end
  for _, path in ipairs(fallbacks) do
    if vim.fn.executable(path) == 1 then
      return path
    end
  end
end

-- Run a converter and return its output lines (CR stripped), or nil + error lines
local function run(cmd)
  local out = vim.fn.systemlist(cmd)
  for i, l in ipairs(out) do
    out[i] = (l:gsub("\r$", ""))
  end
  if vim.v.shell_error ~= 0 then
    return nil, out
  end
  return out
end

-- pdftotext separates pages with form feeds; turn them into visible page markers
local function mark_pages(out)
  local lines, page = {}, 1
  for _, line in ipairs(out) do
    local before, after = line:match("^(.-)\f(.*)$")
    while before do
      table.insert(lines, before)
      page = page + 1
      table.insert(lines, ("──────── page %d ────────"):format(page))
      line = after
      before, after = line:match("^(.-)\f(.*)$")
    end
    table.insert(lines, line)
  end
  -- drop the marker pdftotext's trailing form feed leaves after the last page
  while #lines > 0 and (lines[#lines] == "" or lines[#lines]:match("^──────── page")) do
    table.remove(lines)
  end
  return lines
end

local converters = {
  {
    pattern = "*.pdf",
    tool = "pdftotext",
    fallbacks = { "C:\\Program Files\\Git\\mingw64\\bin\\pdftotext.exe" },
    filetype = "text",
    convert = function(exe, path)
      local out, err = run({ exe, "-layout", path, "-" })
      return out and mark_pages(out), err
    end,
  },
  {
    pattern = { "*.docx", "*.pptx", "*.odt" },
    tool = "pandoc",
    fallbacks = { vim.fn.expand("$LOCALAPPDATA") .. "\\Pandoc\\pandoc.exe", "C:\\Program Files\\Pandoc\\pandoc.exe" },
    filetype = "markdown",
    convert = function(exe, path)
      return run({ exe, path, "-t", "gfm-raw_html", "--wrap=none" })
    end,
  },
}

local group = vim.api.nvim_create_augroup("documents_as_text", { clear = true })

for _, c in ipairs(converters) do
  vim.api.nvim_create_autocmd("BufReadCmd", {
    group = group,
    pattern = c.pattern,
    callback = function(ev)
      local buf = ev.buf
      local path = vim.fn.fnamemodify(ev.match, ":p")
      local exe = find_exe(c.tool, c.fallbacks)

      local lines, filetype = nil, c.filetype
      if not exe then
        lines = { c.tool .. " not found -- press <leader>fo to open this file in its default app." }
        filetype = "text"
      else
        local out, err = c.convert(exe, path)
        if out then
          lines = out
        else
          lines = vim.list_extend({ c.tool .. " failed -- press <leader>fo to open this file in its default app.", "" }, err)
          filetype = "text"
        end
      end

      vim.bo[buf].modifiable = true
      vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
      vim.bo[buf].modifiable = false
      vim.bo[buf].readonly = true
      vim.bo[buf].buftype = "nowrite"
      vim.bo[buf].swapfile = false
      vim.bo[buf].modified = false
      vim.bo[buf].filetype = filetype
    end,
  })
end
