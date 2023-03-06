data:extend({
  {
		type = "string-setting",
		name = "bzfoundry-recipe-bypass",
		setting_type = "startup",
		default_value = "",
    allow_blank = true,
    order = "aaa",
	},
  {
		type = "string-setting",
		name = "bzfoundry-hydrocarbon",
		setting_type = "startup",
    allowed_values = {"coke", "solid-fuel", "coal", "none"},
		default_value = "coke",
    order = "aba",
	},
  {
		type = "bool-setting",
		name = "bzfoundry-smelt",
		setting_type = "startup",
		default_value = false,
    order = "aca",
	},
  {
		type = "string-setting",
		name = "bzfoundry-other-machines",
		setting_type = "startup",
		default_value = "kr-advanced-furnace",
    order = "acb",
	},
  {
		type = "string-setting",
		name = "bzfoundry-plates",
		setting_type = "startup",
		default_value = "no",
    allowed_values = {"yes", "no"},
    order = "acd",
	},
  {
		type = "bool-setting",
		name = "bzfoundry-minimal",
		setting_type = "startup",
		default_value = false,
    hidden = not mods.bzaluminum,
    order = "zza",
	},
})
if not mods.Krastorio2 then
data:extend({
  {
		type = "bool-setting",
		name = "bzfoundry-woodcoke",
		setting_type = "startup",
		default_value = false,
    order = "abb",
	},
})
end
