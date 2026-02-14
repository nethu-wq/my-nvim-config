-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local keymap = vim.keymap
local is_windows = vim.loop.os_uname().version:find("Windows")

--------------------------------------------------
-- UTILITY: STABLE FLOATING TERMINAL
--------------------------------------------------
local function float_terminal(cmd, cwd)
  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    border = "rounded",
  })

  -- On Windows, wrap in shell to ensure Maven (mvn) is found in PATH correctly
  local final_cmd = is_windows and { "cmd.exe", "/c", cmd } or cmd

  vim.fn.termopen(final_cmd, { cwd = cwd })
  vim.cmd("startinsert")
end

--------------------------------------------------
-- PROFESSIONAL JAVA MAVEN PROJECT GENERATOR
--------------------------------------------------
keymap.set("n", "<leader>jp", function()
  local groupId = vim.fn.input("Group ID (e.g. com.mycompany): ")
  if groupId == "" then
    return
  end

  local artifactId = vim.fn.input("Artifact ID (project name): ")
  if artifactId == "" then
    return
  end

  local version = vim.fn.input("Version (default 1.0-SNAPSHOT): ", "1.0-SNAPSHOT")
  local use_git = vim.fn.confirm("Initialize Git?", "&Yes\n&No", 1)

  local sep = is_windows and "\\" or "/"
  local root = vim.fn.getcwd() .. sep .. artifactId
  local package_path = groupId:gsub("%.", sep)

  local main_dir = root .. sep .. "src" .. sep .. "main" .. sep .. "java" .. sep .. package_path
  local test_dir = root .. sep .. "src" .. sep .. "test" .. sep .. "java" .. sep .. package_path

  vim.fn.mkdir(main_dir, "p")
  vim.fn.mkdir(test_dir, "p")

  -- Create Main.java
  local main_file = io.open(main_dir .. sep .. "Main.java", "w")
  if main_file then
    main_file:write(
      "package "
        .. groupId
        .. ';\n\npublic class Main {\n    public static void main(String[] args) {\n        System.out.println("Application started successfully.");\n    }\n}'
    )
    main_file:close()
  end

  -- Create pom.xml with built-in exec config
  local pom = io.open(root .. sep .. "pom.xml", "w")
  if pom then
    pom:write(string.format(
      [[
<project xmlns="http://maven.apache.org/POM/4.0.0">
  <modelVersion>4.0.0</modelVersion>
  <groupId>%s</groupId>
  <artifactId>%s</artifactId>
  <version>%s</version>
  <properties>
    <maven.compiler.source>17</maven.compiler.source>
    <maven.compiler.target>17</maven.compiler.target>
    <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
  </properties>
  <dependencies>
    <dependency>
      <groupId>org.junit.jupiter</groupId>
      <artifactId>junit-jupiter</artifactId>
      <version>5.10.0</version>
      <scope>test</scope>
    </dependency>
  </dependencies>
  <build>
    <plugins>
      <plugin>
        <groupId>org.codehaus.mojo</groupId>
        <artifactId>exec-maven-plugin</artifactId>
        <version>3.1.0</version>
        <configuration>
          <mainClass>%s.Main</mainClass>
        </configuration>
      </plugin>
    </plugins>
  </build>
</project>]],
      groupId,
      artifactId,
      version,
      groupId
    ))
    pom:close()
  end

  if use_git == 1 then
    vim.fn.system("git init " .. root)
  end

  vim.cmd("edit " .. main_dir .. sep .. "Main.java")
  print("Project '" .. artifactId .. "' ready.")
end, { desc = "Java: Create Professional Maven Project" })

--------------------------------------------------
-- REUSABLE RUNNER LOGIC
--------------------------------------------------
local function run_mvn(target)
  vim.cmd("w")
  local pom = vim.fs.find("pom.xml", { upward = true, stop = vim.loop.os_homedir() })[1]
  if not pom then
    print("No pom.xml found.")
    return
  end
  float_terminal("mvn " .. target, vim.fs.dirname(pom))
end

keymap.set("n", "<leader>jr", function()
  run_mvn("compile exec:java")
end, { desc = "Java: Run" })
keymap.set("n", "<leader>jt", function()
  run_mvn("test")
end, { desc = "Java: Test" })
keymap.set("n", "<leader>jc", function()
  run_mvn("clean")
end, { desc = "Java: Clean" }) -- ~~~~~~~~~~~~~~~~ JAVA AUTOMATION ~~~~~~~~~~~~~~~~
