data:extend({
  {
		type = "string-setting",
		name = "bzfoundry-recipe-bypass",
		setting_type = "startup",
		default_value = "",
    allow_blank = true,
	},
  {
		type = "string-setting",
		name = "bzfoundry-hydrocarbon",
		setting_type = "startup",
    allowed_values = {"coke", "solid-fuel", "coal", "none"},
		default_value = "coke",
	},
  {
		type = "bool-setting",
		name = "bzfoundry-smelt",
		setting_type = "startup",
		default_value = false,
	},
  {
		type = "string-setting",
		name = "bzfoundry-other-machines",
		setting_type = "startup",
		default_value = "kr-advanced-furnace",
	},
})
