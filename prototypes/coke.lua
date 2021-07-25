local util = require("data-util")

if util.me.carbon() == "coke" and not data.raw.item["coke"] then
data:extend({
  {
    type = "item",
    name = "coke",
    icon = "__bzfoundry__/graphics/icons/coke-icon.png",
    icon_size = 128,
    pictures = {
      {size = 128, filename = "__bzfoundry__/graphics/icons/coke.png",   scale = 0.125},
      {size = 128, filename = "__bzfoundry__/graphics/icons/coke-1.png", scale = 0.125},
      {size = 128, filename = "__bzfoundry__/graphics/icons/coke-2.png", scale = 0.125},
      {size = 128, filename = "__bzfoundry__/graphics/icons/coke-3.png", scale = 0.125},
    },
    fuel_category = "chemical",
    fuel_value = "10MJ",
    fuel_acceleration_multiplier = 1.2,
    fuel_top_speed_multiplier = 1,
    subgroup = "raw-material",
    order = "c[coke]",
    stack_size = 50
  },
  {
    type = "recipe",
    name = "coke",
    result = "coke",
    category = "founding",
    ingredients = {{"coal", 2}},
    energy_required = 3.2,
    enabled=false,
  },
})
elseif util.me.carbon() == "solid-fuel" then
data:extend({
  {
    type = "recipe",
    name = "solid-fuel-from-coal",
    result = "solid-fuel",
    category = "founding",
    ingredients = {{"coal", 4}},
    energy_required = 3.2,
    enabled=false,
  },
})
end
