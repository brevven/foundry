local util = require("data-util")

-- Prevent production deadlock
if mods.Bio_Industries then
  util.remove_ingredient("foundry", "silica")
end



if data.raw.item["coke"] and not mods.Krastorio2 then
  if deadlock then
    deadlock.add_stack("coke", nil, "deadlock-stacking-1")
  end
  if deadlock_crating then
    deadlock_crating.add_crate("coke", "deadlock-crating-1")
  end
end
