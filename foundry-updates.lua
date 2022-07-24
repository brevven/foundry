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

  util.set_category("solder", "basic-founding")
else
  -- If we're not using Foundry buildings, add founding recipes to assemblers in vanilla, or furnaces in K2
  local sought = mods.Krastorio2 and "smelting" or "crafting" 
  for i, machine in pairs(data.raw["assembling-machine"]) do
    for j, category in pairs(machine.crafting_categories) do
      if category == sought then
        util.add_crafting_category("assembling-machine", machine.name, "founding")
        if util.me.basic_founding() then
          util.add_crafting_category("assembling-machine", machine.name, "basic-founding")
        end
        break
      end
    end
  end
  util.add_crafting_category("assembling-machine", "industrial-furnace", "founding")
  util.add_crafting_category("assembling-machine", "kr-advanced-furnace", "founding")
  if util.me.basic_founding() then
    util.add_crafting_category("assembling-machine", "industrial-furnace", "basic-founding")
    util.add_crafting_category("assembling-machine", "kr-advanced-furnace", "basic-founding")
  end
end

for i, machine in pairs(util.me.get_other_machines()) do
  log("Allowing "..machine.." to handle founding")
  util.add_crafting_category("assembling-machine", machine, "founding")
  if util.me.basic_founding() then
    util.add_crafting_category("assembling-machine", machine, "basic-founding")
  end
end

