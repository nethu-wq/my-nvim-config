x / p	Cut & Paste
diw	Delete Word
ciw	Change Word
dd	Delete Line
Ctrl + r	Redo
Shift + l	Next Tab
Shift + h	Prev Tab
yy: Copy Line
yiw: Copy Word
p: Paste
o: Open new line below.
O: Open new line above.
3yy: Yanks the current line and the two lines below it
w/b:more back and forth wit class words.
(:bd) :this will Delete that buffer only that buffer.
ALT+tab :jumps apps in windows.
CTRL+tab:jumps apps in chrome.
CTRL+tab+Shift:jumps back apps in chrome.
x: removes white spaces.
ysiw: Surround word.
yss(: Surround line.
cs"': Change surround.
ds(: Delete surround.
leader+mb= Run project in java
leader+mn=Create a new java project.
leader+mr=Runs the project faster using direct maven comiler.
r:Replace what ever is under the curser.
R:Keep replaceing.
zz:Zen mode.
leader+sg:Grep.
jk or Esc+Esc: Exit terminal mode.
CTRL+p:previous
CTRL+n:next.
f+character --;:Jumps to the next instance of said charactert.
CTRL+m:Acts as the enter key.
CTRL+y:Excepts auto-correct suggestions.
gcc:To comment an line.
Vsual mode+leader+XX+Chracter :To sorround the selected text.
When nameing java projects:The Rule: Use lowercase letters and hyphens (-) instead of spaces or underscores.
ls: to list all the buffers. + :bd the number of the buffers you want to delete.
Space + d + d:Spawn penguin
Space + d + a:Remove all penguins
Ctrl + d:Select word under cursor, keep pressing to select next match.
Ctrl + Up/Ctrl + Down:Add cursor above/Add cursor below
Space + c + a:Code actionsShows available fixes and suggestions at cursor.
Space + c + r:Rename symbolRenames a variable everywhere it's used in the project.
*+cw+enter the new variable+n+.:When changing mutiple variabales at the same time("n" is to skip to the next instance).
CTRL+h/l=To move between buffers.
SHFIT+h/l=To move between files.
Leader+ha= Pins the current file like a book marks can do upto 5 file.
Alt+1/2/3/4=Can jump between the pinned files
leader+cp=color wheel.
leader+hh=file pin menu.
s in noral mode +first 2 characters:Type the first two chacteres of the word you want to jump to there is a letter that comes after press that to move there.
leader+fmg:game of life
leader+fml:make it rain
leader+cs:Opens a sidebar showing all classes, methods,and functions in the file.
(<leader>gd):Opens a full-screen git diff of every changed file side by side.
<leader>gh shows the entire git history of the current file
<leader>re — wraps selection into a new function, removes it from where it was
<leader>rv — pulls a value into a named variable
<leader>ri j does the opposite, inlines a variable back
<leader>rb — extracts a block of code
/:??????????????????????????????????????
c+f+the letter -it will clear up to it and convert to insert mode.
leader+c+f-manual auto famatting for any file type.

  Claude Code
  - <leader>ac — toggle Claude Code
  - <leader>af — focus Claude Code
  - <leader>ar — resume session
  - <leader>ab — add current buffer
  - <leader>as — send selection (visual)
  - <leader>aa / <leader>ad — accept / deny diff 

  Harpoon
  - <leader>ha — add file
  - <leader>hh — open menu
  - <M-1> <M-2> <M-3> <M-4> — jump to pinned file

  Maven
  - <leader>mn — new project (prompts for name + 
  group ID)
  - <leader>mb — build & run (mvn clean package →
   java -jar)
  - <leader>mr — run (mvn exec:java)
  - <leader>mt — test (mvn test)
  - <leader>mc — clean (mvn clean)
  - <leader>mp — package JAR

  Navigation / Tools
  - <leader>cs — aerial symbol outline toggle    
  - [a / ]a — aerial prev / next symbol
  - <leader>gd — diffview open
  - <leader>gh — file git history
  - <leader>gD — diffview close
  - <leader>z — zen mode
  - <leader>tw — twilight

  Editing
  - jk — exit insert mode (also works in
  terminal)
  - <Esc><Esc> — exit terminal mode
  - <C-d> — multi-cursor (vim-visual-multi)      
  - <C-↑> / <C-↓> — add cursor up / down
  - <leader>XX — surround selection (visual)     
  - <leader>cp — color picker (ccc.nvim)
  - <leader>re — extract function (visual)       
  - <leader>rv — extract variable (visual)       
  - <leader>ri — inline variable
  - <leader>rb — extract block
  - <C-\> — toggle terminal

  Fun
  - <leader>dd — hatch penguin
  - <leader>dk — cook penguin
  - <leader>da — cook all
  - <leader>fml — make it rain
  - <leader>fmg — game of life
