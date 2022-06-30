local util = require("data-util")

if util.me.enable() then
  util.set_to_founding("steel-plate")
  util.replace_some_ingredient("steel-plate", "iron-plate", 1, util.me.carbon(), 1)
  util.multiply_time("steel-plate", 4/5)
  util.add_prerequisite("steel-processing", "foundry")

  util.set_to_founding("tungsten-carbide")
  util.add_ingredient("tungsten-carbide", util.me.carbon(), 1)


  util.set_to_founding("silicon")
  util.add_ingredient("silicon", util.me.carbon(), 1)

  util.set_to_founding("cermet")  -- from zirconium
  util.set_to_founding("crucible") -- from graphite
else
  -- If we're not using Foundry buildings, add founding recipes to assemblers in vanilla, or furnaces in K2
  local sought = mods.Krastorio2 and "smelting" or "crafting" 
  log ("looking for "..sought)
  for i, machine in pairs(data.raw["assembling-machine"]) do
    log(serpent.dump(machine))
    for j, category in pairs(machine.crafting_categories) do
      if category == sought then
        log ("found  "..category)
        util.add_crafting_category("assembling-machine", machine.name, "founding")
        break
      end
    end
  end
  util.add_crafting_category("assembling-machine", "industrial-furnace", "founding")
  util.add_crafting_category("assembling-machine", "kr-advanced-furnace", "founding")
end

for i, machine in pairs(util.me.get_other_machines()) do
  log("Allowing "..machine.." to handle founding")
  util.add_crafting_category("assembling-machine", machine, "founding")
end

