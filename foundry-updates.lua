local util = require("data-util")

util.set_to_founding("steel-plate")
util.replace_some_ingredient("steel-plate", "iron-plate", 1, util.carbon(), 1)
util.multiply_time("stee-plate", 4/5)
util.add_prerequisite("steel-processing", "foundry")

util.set_to_founding("tungsten-carbide")
util.add_ingredient("tungsten-carbide", util.carbon(), 1)

util.set_to_founding("silicon")
util.add_ingredient("silicon", util.carbon(), 1)

util.set_to_founding("cermet")
