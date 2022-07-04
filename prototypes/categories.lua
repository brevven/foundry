data:extend({
  { type = "recipe-category", name = "founding"},
  { type = "item-subgroup", name = "founding-machines", group = "production"},
  { type = "item-subgroup", name = "foundry-intermediate", group = "intermediate-products"},
})

if mods.bztin or mods.bzaluminum then
data:extend({
  { type = "recipe-category", name = "basic-founding"},
})
for i, character in pairs(data.raw.character) do
  table.insert(character.crafting_categories, "basic-founding")
end
end
