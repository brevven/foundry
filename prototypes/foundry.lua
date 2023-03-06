local util = require("data-util")

local foundry_ingredients = {{"stone-brick", 20}, {"iron-plate", 10}, {"copper-plate", 5}}
if mods.bzlead then table.insert(foundry_ingredients, {"lead-plate", 8}) end
if mods.Krastorio2 or mods["aai-industry"] then
  table.insert(foundry_ingredients, {"sand", 10})
elseif data.raw.item["silica"] and data.raw.technology["silica-processing"] then
  table.insert(foundry_ingredients, {"silica", 20})
end

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
    ingredients = foundry_ingredients,
  },
  {
    type = "technology",
    name = "foundry",
    icon_size = 256,
    icon = "__bzfoundry__/graphics/icons/technology/foundry.png",
    prerequisites = {"automation"},
    effects = {
      {type = "unlock-recipe", recipe = "foundry"},
      util.me.carbonrecipe() and {type = "unlock-recipe", recipe = util.me.carbonrecipe()},
    },
    unit = {
      count = 25,
      ingredients = {{"automation-science-pack", 1}},
      time = 10,
    },
    order = "foundry",
  },
})
if util.me.woodcoke() then
  util.add_unlock("foundry", "woodcoke")
end

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

if util.me.founding_plates() then
  data:extend({
    {
      type = "technology",
      name = "advanced-founding",
      icons = {
        {icon = "__bzfoundry__/graphics/icons/technology/foundry.png", icon_size = 256},
        (mods.bzcarbon and
         { icon = "__bzcarbon__/graphics/icons/graphite-2.png",
           icon_size = 128, scale=0.5, shift={32, -32}})
        or (mods.bzsilicon and
            { icon = "__bzsilicon__/graphics/icons/silica.png",
              icon_size = 64, scale=1, icon_mipmaps = 3, shift={32, -32}})
        or (mods.bzzirconium and
            { icon = "__bzzirconium__/graphics/icons/zirconia.png",
              icon_size = 128, scale=0.5, shift={32, -32}})
        or (mods.bzaluminum and
            { icon = "__bzaluminum__/graphics/icons/alumina.png",
              icon_size = 128, scale=0.5, shift={32, -32}})
        or { icon = "__base__/graphics/icons/stone-brick.png",
             icon_size = 64, scale=1, icon_mipmaps = 4, shift={32, -32}}
      },
      effects = {},
      prerequisites = {"electric-foundry", "utility-science-pack"},
      unit = {
        count = 1000,
        ingredients = {{"automation-science-pack", 1},
                       {"logistic-science-pack", 1},
                       {"chemical-science-pack", 1},
                       {"production-science-pack", 1},
                       {"utility-science-pack", 1}},
        time = 60,
      },
      order = "foundry",
    }
  })
  if mods["space-exploration"] then
    data:extend({
      {
        type = "technology",
        name = "advanced-founding-space",
        icons = {
          {icon = "__bzfoundry__/graphics/icons/technology/foundry.png", icon_size = 256},
          (mods.bzcarbon and
           { icon = "__bzcarbon__/graphics/icons/graphite-2.png",
             icon_size = 128, scale=0.5, shift={32, -32}})
          or (mods.bzsilicon and
              { icon = "__bzsilicon__/graphics/icons/silica.png",
                icon_size = 64, scale=1, icon_mipmaps = 3, shift={32, -32}})
          or (mods.bzzirconium and
              { icon = "__bzzirconium__/graphics/icons/zirconia.png",
                icon_size = 128, scale=0.5, shift={32, -32}})
          or (mods.bzaluminum and
              { icon = "__bzaluminum__/graphics/icons/alumina.png",
                icon_size = 128, scale=0.5, shift={32, -32}})
          or { icon = "__base__/graphics/icons/stone-brick.png",
               icon_size = 64, scale=1, icon_mipmaps = 4, shift={32, -32}}
        },
        effects = {},
        prerequisites = {
          "advanced-founding",
          "se-processing-holmium",
          "se-processing-iridium",
          "se-processing-beryllium",
        },
        unit = {
          count = 1000,
          ingredients = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1},
            {"utility-science-pack", 1},
            {"se-rocket-science-pack", 1},
          },
          time = 60,
        },
        order = "foundry",
      }
    })
  end
end
