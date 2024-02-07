local util = require("data-util")

data:extend({
  { type = "recipe-category", name = "founding"},
  { type = "item-subgroup", name = "founding-machines", group = "production", order = "d-f"},
  { type = "item-subgroup", name = "foundry-intermediate", group = "intermediate-products",
    order = util.se6() and "a-b-z" or "c-z"},
})

if util.me.basic_founding() then
  data:extend({
    { type = "recipe-category", name = "basic-founding"},
  })
  for i, character in pairs(data.raw.character) do
    if character.crafting_categories then
      table.insert(character.crafting_categories, "basic-founding")
    end
  end
end
