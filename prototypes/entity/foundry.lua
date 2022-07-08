require("util")
local futil = require("data-util")

local fuel = {"chemical"}
if mods.Krastorio2 then table.insert(fuel, "vehicle-fuel") end
if mods["aai-industry"] then table.insert(fuel, "processed-chemical") end

data:extend({
  {
    type = "assembling-machine",
    name = "foundry",
    fast_replaceable_group = "foundry",
    icon = "__bzfoundry__/graphics/icons/foundry.png",
    icon_size = 64,
    flags = {"placeable-neutral", "placeable-player", "player-creation"},
    minable = {mining_time = 0.2, result = "foundry"},
    max_health = 300,
    corpse = "medium-small-remnants",
    vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
    working_sound =
    {
      sound = { filename = "__base__/sound/furnace.ogg" }
    },
    resistances =
    {
      {
        type = "fire",
        percent = 100
      }
    },
    collision_box = {{-1.7, -1.7}, {1.7, 1.7}},
    selection_box = {{-2, -2}, {2, 2}},
    crafting_categories = {"founding", futil.me.smelt() and "smelting" or nil},
    energy_usage = "180kW",
    crafting_speed = 4,
    energy_source =
    {
      type = "burner",
      fuel_categories = fuel,
      effectivity = 1,
      emissions_per_minute = 8,
      fuel_inventory_size = 1,
      smoke =
      {
        {
          name = "smoke",
          frequency = 20,
          position = {1, -1.7},
          starting_vertical_speed = 0.1,
          starting_frame_deviation = 60
        }
      }
    },
    animation =
    {
      layers =
      {
        {
          filename = "__bzfoundry__/graphics/entity/hr-foundry-base.png",
          priority = "high",
          width = 512,
          height = 512,
          frame_count = 1,
          scale = 0.38
        },
      }
    },
    working_visualisations =
    {
      {
        north_position = {0.0, 0.0},
        east_position = {0.0, 0.0},
        south_position = {0.0, 0.0},
        west_position = {0.0, 0.0},
        animation =
        {
          filename = "__bzfoundry__/graphics/entity/hr-foundry-animation.png",
          priority = "extra-high",
          line_length = 3,
          lines_per_file = 3,
          width = 512,
          height = 512,
          frame_count = 9,
          shift = util.by_pixel(0, 0),
          animation_speed = 0.2,
          scale=0.38,
        },
      }
    },

  },

})

futil.add_crafting_category("assembling-machine", "foundry", "basic-founding")
