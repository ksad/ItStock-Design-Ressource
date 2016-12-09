--[[--
  Use this file to specify **User** preferences.
  Review [examples](+C:\Users\sad\Documents\MY_PROJECTS\Tools\ZeroBraneStudio\cfg\user-sample.lua) or check [online documentation](http://studio.zerobrane.com/documentation.html) for details.
--]]--
---[[

local G = ...

styles = G.loadfile('cfg/tomorrow.lua')('Monokai')

stylesoutshell = styles -- apply the same scheme to Output/Console windows

styles.auxwindow = styles.text -- apply text colors to auxiliary windows

styles.calltip = styles.text -- apply text colors to tooltips

editor.fold = false

editor.tabwidth = 4

editor.usetabs = true

editor.usewrap = false

editor.showfncall = false

editor.extraascent = nil

 

-- from <!-- m --><a class="postlink" href="https://gist.github.com/riidom/6001731">https://gist.github.com/riidom/6001731</a><!-- m -->

styles.indicator.fncall = {fg = {204,147,147} } -- function calls just underlined

styles.indicator.varlocal = nil -- for local vars no special marker

styles.indicator.varglobal = nil -- global vars red underline

 

keymap[G.ID_VIEWFULLSCREEN] = "F11"

 

styles.linenumber.fg = {80,80,50}

 

styles.keywords0.b = false -- no bold keywords

styles.keywords2.b = false -- - " -

--]]
