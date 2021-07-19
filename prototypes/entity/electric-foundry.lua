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
    crafting_categories = {"founding", futil.smelt() and "smelting" or nil},
    energy_usage = "90kW",
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
          -- TODO make a non-hr version
          filename = "__bzfoundry__/graphics/entity/hr-electric-foundry.png",
          priority = "high",
          width = 280,
          height = 239,
          frame_count = 1,
          shift = util.by_pixel(8, 4),
          scale = 0.5,
          hr_version =
          {
            filename = "__bzfoundry__/graphics/entity/hr-electric-foundry.png",
            priority = "high",
            width = 280,
            height = 239,
            frame_count = 1,
            shift = util.by_pixel(8, 4),
            scale = 0.5,
          }
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
          filename = "__bzfoundry__/graphics/entity/hr-electric-foundry-animation.png",
          priority = "extra-high",
          animation_speed = 0.05,
          line_length = 4,
          width = 280,
          height = 239,
          frame_count = 4,
          axially_symmetrical = false,
          direction_count = 1,
          shift = util.by_pixel(8, 4),
          scale = 0.5,
          hr_version =
          {
            filename = "__bzfoundry__/graphics/entity/hr-electric-foundry-animation.png",
            priority = "extra-high",
            animation_speed = 0.05,
            line_length = 4,
            width = 280,
            height = 239,
            frame_count = 4,
            axially_symmetrical = false,
            direction_count = 1,
            shift = util.by_pixel(8, 4),
            scale = 0.5,
          }
        },
      },
      {
        fadeout = true,
        draw_as_light = true,
        effect = "flicker",
        animation =
        {
          filename = "__bzfoundry__/graphics/entity/electric-foundry-glow.png",
          priority = "extra-high",
          width = 25,
          height = 29,
          frame_count = 1,
          shift = util.by_pixel(0, 36),
        }
      },
      {
        draw_as_light = true,
        draw_as_sprite = false,
        fadeout = true,
        effect = "flicker",
        animation =
        {
          filename = "__base__/graphics/entity/steel-furnace/steel-furnace-ground-light.png",
          priority = "high",
          line_length = 1,
          draw_as_sprite = false,
          width = 78,
          height = 64,
          frame_count = 1,
          direction_count = 1,
          shift = util.by_pixel(0, 72),
          blend_mode = "additive",
          hr_version =
          {
            filename = "__base__/graphics/entity/steel-furnace/hr-steel-furnace-ground-light.png",
            priority = "high",
            line_length = 1,
            draw_as_sprite = false,
            width = 152,
            height = 126,
            frame_count = 1,
            direction_count = 1,
            shift = util.by_pixel(1, 72),
            blend_mode = "additive",
            scale = 0.5,
          }
        },
      },
    },

  },

})
