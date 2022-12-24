local util = require("data-util")
require("refractory-updates")

-- Prevent production deadlock
if mods.Bio_Industries then
  util.remove_ingredient("foundry", "silica")
end



if data.raw.item["coke"] and not mods.Krastorio2 then
  if deadlock then
    deadlock.add_stack("coke", "__bzfoundry__/graphics/icons/coke-stacked.png", "deadlock-stacking-1", 128)
  end
  if deadlock_crating then
    deadlock_crating.add_crate("coke", "deadlock-crating-1")
  end
end


util.add_to_product("vtk-deepcore-mining-ore-chunk-refining-coal-focus", "vtk-deepcore-mining-coal-chunk", 8)
util.add_to_product("vtk-deepcore-mining-ore-chunk-refining", "vtk-deepcore-mining-coal-chunk", 10)
util.add_to_product("vtk-deepcore-mining-ore-chunk-refining-no-uranium", "vtk-deepcore-mining-coal-chunk", 10)
util.set_vtk_dcm_ingredients()

