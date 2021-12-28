local util = require("data-util")

-- Prevent production deadlock
if mods.Bio_Industries then
  util.remove_ingredient("foundry", "silica")
end
