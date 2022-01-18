local rusty_locale = require("__rusty-locale__.locale")
local rusty_icons = require("__rusty-locale__.icons")
local rusty_recipes = require("__rusty-locale__.recipes")
local rusty_prototypes = require("__rusty-locale__.prototypes")
local futil = require("util")
local util = require("data-util")


function has_suffix(s, suffix)
  return string.sub(s, -string.len(suffix), -1) == suffix
end

local suffixes = {"-plate", "-ingot"}
function check_name(name)
  for i, suffix in pairs(suffixes) do
    if has_suffix(name, suffix) then return true end
  end
  return false
end

function make_recipe(recipe)
  log("checking "..recipe.name)
  local found_result = false
  local has_normal = false
  local has_exp = false


  local new_results = {}
  local new_normal_results = {}
  local new_exp_results = {}

  if recipe.results then -- standard recipes
    for i, result in pairs(recipe.results) do
      if (result.name and check_name(result.name)) or 
        (result[1] and check_name(result[1])) then
        found_result = result.name
        new_results = futil.table.deepcopy(recipe.results)
        break
      end
    end
  end

  if recipe.result and check_name(recipe.result) then
    found_result = recipe.result
    new_results = {{recipe.result, recipe.result_count or 1}}
  end

  if recipe.normal then
    has_normal = true
    if recipe.normal.results then
      for i, result in pairs(recipe.normal.results) do
        if (result.name and check_name(result.name)) or 
          (result[1] and check_name(result[1])) then
          found_result = result.name
          new_normal_results = futil.table.deepcopy(recipe.normal.results)
          break
        end
      end
    end

    if recipe.normal.result and check_name(recipe.normal.result) then
      found_result = recipe.normal.result
      new_normal_results = {{recipe.normal.result, recipe.result_count or 1}}
    end
  end

  if recipe.expensive then
    has_exp = true
    if recipe.expensive.results then
      for i, result in pairs(recipe.expensive.results) do
        if (result.name and check_name(result.name)) or 
          (result[1] and check_name(result[1])) then
          found_result = result.name
          new_exp_results = futil.table.deepcopy(recipe.expensive.results)
          break
        end
      end
    end

    if recipe.expensive.result and check_name(recipe.expensive.result) then
      found_result = recipe.expensive.result
      new_exp_results = {{recipe.expensive.result, recipe.result_count or 1}}
    end
  end

  if found_result then
    log("Attempting to make refractory recipe for " .. recipe.name)
    local r = futil.table.deepcopy(recipe)
    r.name = r.name .. "-refractory"
    r.result = nil
    r.result_count = nil
    r.enabled = false
    r.category = "founding"
    r.subgroup = data.raw.item[found_result].subgroup
    icons = rusty_icons.of(data.raw.recipe[recipe.name])
    table.insert(icons,
        mods.bzcarbon and
        { icon = "__bzcarbon__/graphics/icons/graphite-2.png",
          icon_size = 128, scale=0.125, shift={8, -8}}
        or
        { icon = "__bzsilicon__/graphics/icons/silica.png",
          icon_size = 64, scale=0.25, icon_mipmaps = 3, shift={8, -8}})
    r.icons = icons
    locale = rusty_locale.of_recipe(data.raw.recipe[recipe.name])
    r.localised_name = {"recipe-name.with-refractory", locale.name}

    if not has_normal and not has_exp then
      r.results = new_results
      make_ingredients_and_products(r)
    end
    if has_normal then
      r.normal.results = new_normal_results
      r.normal.result = nil
      r.normal.result_count = nil
      r.normal.enabled = false
      make_ingredients_and_products(r.normal)
    end
    if has_exp then
      r.expensive.results = new_exp_results
      r.expensive.result = nil
      r.expensive.result_count = nil
      r.expensive.enabled = false
      make_ingredients_and_products(r.expensive)
    end
    return r
  end
  return nil
end


-- Gets refractories for a recipe (currently all recipes use same refractories)
function get_refractories(recipe)
  local refractories = {}
  if mods.bzcarbon then table.insert(refractories, "graphite") end
  if mods.bzsilicon then table.insert(refractories, "silica") end
  if #refractories < 2 and mods.bzzirconium then table.insert("zirconia") end
  return refractories
end

function make_ingredients_and_products(r)
  local refractories = get_refractories(r)
  local max_count = 1
  for i, ingredient in pairs(r.ingredients) do
    if ingredient[2] and ingredient[2] > max_count then
      max_count = ingredient[2]
    end
    if ingredient.amount and ingredient.amount > max_count then
      max_count = ingredient.amount
    end
  end
  for i, refractory in pairs(refractories) do
    table.insert(r.ingredients, {refractory, max_count})
  end

  for i, result in pairs(r.results) do
    if result[1] and check_name(result[1]) then
      result[2] = result[2]*2
      break
    end
    if result.name and check_name(result.name) then
      if result.amount then
        result.amount = result.amount * 2
      end
      if result.amount_min then
        result.amount_min = result.amount_min * 2
      end
      if result.amount_max then
        result.amount_max = result.amount_max * 2
      end
      break
    end
  end
  for i, refractory in pairs(refractories) do
    table.insert(r.results, {type="item", name=refractory, amount=max_count,
        probability=get_probability(#refractories)})
  end
end

local roots = {0.5, 0.7, 0.8, 0.84, 0.87, 0.89, 0.9}
-- returns approx nth root of 0.5
function get_probability(n)
  return roots[n]
end

if util.me.founding_plates() and (mods.bzcarbon or mods.bzsilicon or mods.bzzirconium)  then
  local new_recipes = {}
  for name, recipe in pairs(data.raw.recipe) do 
    if recipe.category ~= "smelting" then goto continue end
    if name == "steel-plate" or name == "se-naquium-ingot" then goto continue end
    local new_recipe = make_recipe(recipe)
    if new_recipe then
      table.insert(new_recipes, new_recipe)
    end
    ::continue::
  end
  data:extend(new_recipes)
  for i, recipe in pairs(new_recipes) do
    -- recipe unlock
    util.add_effect("advanced-founding", {type="unlock-recipe", recipe=recipe.name})
    
    -- prod modules
    for j, module in pairs(data.raw.module) do
      if module.effect then
        for effect_name, effect in pairs(module.effect) do
          if effect_name == "productivity" and effect.bonus > 0 and module.limitation and #module.limitation > 0 then
            table.insert(module.limitation, recipe.name)
          end
        end
      end
    end
  end
end
