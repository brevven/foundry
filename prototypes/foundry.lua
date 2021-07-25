local util = require("data-util")

data:extend({
  { type = "recipe-category", name = "founding"},
  { type = "item-subgroup", name = "founding-machines", group = "production"},
  { type = "item-subgroup", name = "foundry-intermediate", group = "intermediate-products"},
})

data:extend({
  {
    type = "item",
    name = "foundry",
    icon = "__bzfoundry__/graphics/icons/foundry.png",
    icon_size = 64,
    subgroup = "founding-machines",
    order = "z[foundry]",
    place_result = "foundry",
    stack_size = 50
  },
  {
    type = "recipe",
    name = "foundry",
    result = "foundry",
    enabled = false,
    ingredients = {
      {"stone-brick", 20}, 
      {"iron-plate", 10}, 
      {"copper-plate", 5},
      (mods.bzlead and {"lead-plate", 10} or nil), 
      ((mods.Krastorio2 or mods["aai-industry"]) and {"sand", 10}) or 
      (data.raw.item["silica"] and data.raw.technology["silica-processing"] and {"silica", 20}) or nil,
    },
  },
  {
    type = "technology",
    name = "foundry",
    icon_size = 256,
    icon = "__bzfoundry__/graphics/icons/technology/foundry.png",
    prerequisites = {"automation"},
    effects = {
      {type = "unlock-recipe", recipe = "foundry"},
      util.carbonrecipe() and {type = "unlock-recipe", recipe = util.carbonrecipe()},
    },
    unit = {
      count = 25,
      ingredients = {{"automation-science-pack", 1}},
      time = 10,
    },
    order = "foundry",
  },
   
})
if mods.Krastorio2 then
  util.add_prerequisite("foundry", "kr-stone-processing")
elseif mods["aai-industry"] then
  util.add_prerequisite("foundry", "sand-processing")
else
  util.add_prerequisite("foundry", "silica-processing")
end

data:extend({
  {
    type = "item",
    name = "electric-foundry",
    icon = "__bzfoundry__/graphics/icons/electric-foundry.png",
    icon_size = 128,
    subgroup = "founding-machines",
    order = "z[foundryelectric]",
    place_result = "electric-foundry",
    stack_size = 50
  },
  {
  {
		type = "bool-setting",
		name = "bzfoundry-smelt",
		setting_type = "startup",
		default_value = false,
	},
    type = "recipe",
    name = "electric-foundry",
    result = "electric-foundry",
    enabled = false,
    ingredients = {
      {"foundry", 1},
      {"steel-plate", 10},
      {"processing-unit", 4},
      {"concrete", 10},
      (data.raw.item["zirconia"] and {"zirconia", 10} or {"stone-brick", 10}), 
      (data.raw.item["tungsten-plate"] and {"tungsten-plate", 5} or nil),
    },
  },
  {
    type = "technology",
    name = "electric-foundry",
    icon_size = 256,
    icon = "__bzfoundry__/graphics/icons/technology/electric-foundry.png",
    prerequisites = {"automation-3"},
    effects = {
      {type = "unlock-recipe", recipe = "electric-foundry"},
    },
    unit = {
      count = 200,
      ingredients = {{"automation-science-pack", 1},
                     {"logistic-science-pack", 1},
                     {"chemical-science-pack", 1},
                     {"production-science-pack", 1}},
      time = 45,
    },
    order = "foundry",
  },
   
})
