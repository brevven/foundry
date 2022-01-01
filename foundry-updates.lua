local util = require("data-util")

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

-- K2
for i, machine in pairs(util.me.get_other_machines()) do
  log("Allowing "..machine.." to handle founding")
  util.add_crafting_category("assembling-machine", machine, "founding")
end

