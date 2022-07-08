require("util")
local futil = require("data-util")

data:extend({
  {
    type = "assembling-machine",
    name = "electric-foundry",
    fast_replaceable_group = "foundry",
    icon = "__bzfoundry__/graphics/icons/foundry.png",
    icon_size = 64,
    flags = {"placeable-neutral", "placeable-player", "player-creation"},
    minable = {mining_time = 0.2, result = "electric-foundry"},
    max_health = 300,
    corpse = "medium-small-remnants",
    vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
    working_sound =
    {
      sound = { filename = "__base__/sound/electric-furnace.ogg" }
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
    energy_usage = "360kW",
    drain = "12kW",
    crafting_speed = 4,
    energy_source =
    {
      type = "electric",
      fuel_category = "chemical",
      effectivity = 1,
      emissions_per_minute = 2,
      usage_priority = "secondary-input",
    },
    module_specification =
    {
      module_slots = 3,
      module_info_icon_shift = {0, 0.8}
    },
    allowed_effects = {"consumption", "speed", "productivity", "pollution"},
    animation =
    {
      layers =
      {
        {
          filename = "__bzfoundry__/graphics/entity/hr-electric-foundry-base.png",
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
        light = {
          type = "basic",
          intensity = 1,
          size = 12,
          color = {r=0.78 ,g=0.5 ,b=0.09 },
        }
      },
    },

  },

})

futil.add_crafting_category("assembling-machine", "electric-foundry", "basic-founding")
