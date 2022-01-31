local me =  {}

me.name = "bzfoundry"

function me.founding_plates()
  return me.get_setting("bzfoundry-plates") == "yes"
end

function me.smelt()
  return me.get_setting("bzfoundry-smelt")
end

function me.carbon()
  return me.get_setting("bzfoundry-hydrocarbon")
end

function me.carbonrecipe()
  local carbon = me.carbon()
  if carbon == "coke" then
    return "coke"
  elseif carbon == "solid-fuel" then
    return "solid-fuel-from-coal"
  end
  return nil
end

function me.get_other_machines()
  local machines = {}
  if me.get_setting(me.name.."-other-machines") then 
    for machine in string.gmatch(me.get_setting(me.name.."-other-machines"), '[^",%s]+') do
      table.insert(machines, machine)
    end
  end
  return machines
end

function me.get_setting(name)
  if settings.startup[name] == nil then
    return nil
  end
  return settings.startup[name].value
end

me.bypass = {}
if me.get_setting(me.name.."-recipe-bypass") then 
  for recipe in string.gmatch(me.get_setting(me.name.."-recipe-bypass"), '[^",%s]+') do
    me.bypass[recipe] = true
  end
end

function me.add_modified(name) 
  if me.get_setting(me.name.."-list") then 
    table.insert(me.list, name)
  end
end

return me
