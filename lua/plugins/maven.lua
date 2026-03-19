return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = { shade_terminals = false },
  },
  {
    dir = vim.fn.stdpath("config"),
    name = "maven-keymaps",
    lazy = false,
    config = function()
      local Terminal = require("toggleterm.terminal").Terminal

      local function run_in_term(cmd)
        local t = Terminal:new({
          cmd = string.format('cmd /k "%s"', cmd),
          direction = "float",
          float_opts = {
            border = "rounded",
            width = math.floor(vim.o.columns * 0.85),
            height = math.floor(vim.o.lines * 0.80),
          },
          close_on_exit = false,
          on_open = function(term)
            vim.cmd("startinsert!")
            local opts = { buffer = term.bufnr, silent = true }
            vim.keymap.set("t", "q", function()
              term:close()
            end, opts)
            vim.keymap.set("n", "q", function()
              term:close()
            end, opts)
          end,
        })
        t:toggle()
      end

      local function find_root()
        local path = vim.fn.getcwd()
        for _ = 1, 6 do
          if vim.fn.filereadable(path .. "\\pom.xml") == 1 then
            return path
          end
          local parent = vim.fn.fnamemodify(path, ":h")
          if parent == path then
            break
          end
          path = parent
        end
        return nil
      end

      local function artifact_id(root)
        for line in io.lines(root .. "\\pom.xml") do
          local id = line:match("<artifactId>(.+)</artifactId>")
          if id then
            return id
          end
        end
        return "app"
      end

      local function write_file(path, content)
        vim.fn.mkdir(vim.fn.fnamemodify(path, ":h"), "p")
        local f = io.open(path, "w")
        if f then
          f:write(content)
          f:close()
        end
      end

      vim.keymap.set("n", "<leader>mn", function()
        local name = vim.fn.input("Project name: ")
        if name == "" then
          return
        end
        local group = vim.fn.input("Group ID (default: com.example): ")
        if group == "" then
          group = "com.example"
        end
        local pkg = group:gsub("%.", "\\")
        local cwd = vim.fn.getcwd()
        local base = cwd .. "\\" .. name

        write_file(
          base .. "\\pom.xml",
          string.format(
            [[<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0
                             http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    <groupId>%s</groupId>
    <artifactId>%s</artifactId>
    <version>1.0-SNAPSHOT</version>
    <packaging>jar</packaging>
    <properties>
        <maven.compiler.source>21</maven.compiler.source>
        <maven.compiler.target>21</maven.compiler.target>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
        <mainClass>%s.Main</mainClass>
    </properties>
    <dependencies>
        <dependency>
            <groupId>org.junit.jupiter</groupId>
            <artifactId>junit-jupiter</artifactId>
            <version>5.10.2</version>
            <scope>test</scope>
        </dependency>
    </dependencies>
    <build>
        <plugins>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-compiler-plugin</artifactId>
                <version>3.13.0</version>
            </plugin>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-surefire-plugin</artifactId>
                <version>3.2.5</version>
            </plugin>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-jar-plugin</artifactId>
                <version>3.4.1</version>
                <configuration>
                    <archive>
                        <manifest>
                            <mainClass>${mainClass}</mainClass>
                        </manifest>
                    </archive>
                    <finalName>%s</finalName>
                </configuration>
            </plugin>
            <plugin>
                <groupId>org.codehaus.mojo</groupId>
                <artifactId>exec-maven-plugin</artifactId>
                <version>3.2.0</version>
                <configuration>
                    <mainClass>${mainClass}</mainClass>
                </configuration>
            </plugin>
        </plugins>
    </build>
</project>]],
            group,
            name,
            group,
            name
          )
        )

        write_file(
          base .. "\\src\\main\\java\\" .. pkg .. "\\Main.java",
          string.format(
            [[package %s;

public class Main {
    public static void main(String[] args) {
        System.out.println("Hello from %s!");
        System.out.println("Java version: " + System.getProperty("java.version"));
    }
}]],
            group,
            name
          )
        )

        write_file(
          base .. "\\src\\test\\java\\" .. pkg .. "\\MainTest.java",
          string.format(
            [[package %s;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

class MainTest {
    @Test
    void sampleTest() {
        assertTrue(true, "Placeholder test passes");
    }
}]],
            group
          )
        )

        write_file(base .. "\\.gitignore", "target/\n*.class\n*.jar\n.idea/\n*.iml\n.vscode/\n")
        vim.fn.mkdir(base .. "\\src\\main\\resources", "p")
        vim.fn.mkdir(base .. "\\src\\test\\resources", "p")
        vim.notify("Project '" .. name .. "' created! Use <leader>mb to build.", vim.log.levels.INFO)
        vim.cmd("edit " .. vim.fn.fnameescape(base .. "\\src\\main\\java\\" .. pkg .. "\\Main.java"))
      end, { desc = "Maven: New project" })

      vim.keymap.set("n", "<leader>mb", function()
        local root = find_root()
        if not root then
          vim.notify("No pom.xml found.", vim.log.levels.ERROR)
          return
        end
        local jar = root .. "\\target\\" .. artifact_id(root) .. ".jar"
        run_in_term(
          string.format(
            'cd /d "%s" && echo Building... && mvn clean package -q && echo Running... && java -jar "%s"',
            root,
            jar
          )
        )
      end, { desc = "Maven: Build & Run" })

      vim.keymap.set("n", "<leader>mr", function()
        local root = find_root()
        if not root then
          vim.notify("No pom.xml found.", vim.log.levels.ERROR)
          return
        end
        run_in_term(string.format('cd /d "%s" && mvn exec:java', root))
      end, { desc = "Maven: Run" })

      vim.keymap.set("n", "<leader>mt", function()
        local root = find_root()
        if not root then
          vim.notify("No pom.xml found.", vim.log.levels.ERROR)
          return
        end
        run_in_term(string.format('cd /d "%s" && mvn test', root))
      end, { desc = "Maven: Test" })

      vim.keymap.set("n", "<leader>mc", function()
        local root = find_root()
        if not root then
          vim.notify("No pom.xml found.", vim.log.levels.ERROR)
          return
        end
        run_in_term(string.format('cd /d "%s" && mvn clean', root))
      end, { desc = "Maven: Clean" })

      vim.keymap.set("n", "<leader>mp", function()
        local root = find_root()
        if not root then
          vim.notify("No pom.xml found.", vim.log.levels.ERROR)
          return
        end
        run_in_term(string.format('cd /d "%s" && mvn package', root))
      end, { desc = "Maven: Package JAR" })

      local ok, wk = pcall(require, "which-key")
      if ok then
        wk.add({
          { "<leader>m", group = "Maven" },
          { "<leader>mn", desc = "New project" },
          { "<leader>mb", desc = "Build & Run" },
          { "<leader>mr", desc = "Run" },
          { "<leader>mt", desc = "Test" },
          { "<leader>mc", desc = "Clean" },
          { "<leader>mp", desc = "Package JAR" },
        })
      end
    end,
  },
}
