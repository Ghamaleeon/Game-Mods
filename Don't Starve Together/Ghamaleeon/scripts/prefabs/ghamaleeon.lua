local MakePlayerCharacter = require "prefabs/player_common"

local assets = {
	Asset("SCRIPT", "scripts/prefabs/player_common.lua"),
}

TUNING.GHAMALEEON_HEALTH = 75
TUNING.GHAMALEEON_HUNGER = 150
TUNING.GHAMALEEON_SANITY = 150

TUNING.GAMEMODE_STARTING_ITEMS.DEFAULT.GHAMALEEON = {}

local start_inv = {}
for k, v in pairs(TUNING.GAMEMODE_STARTING_ITEMS) do
	start_inv[string.lower(k)] = v.GHAMALEEON
end
local prefabs = FlattenTree(start_inv, true)


local function CanDissolve(item) -- Can consume food, skins (pig skin example), grasses and twigs
	local testvalues = {FOODGROUP.OMNI, FOODTYPE.HORRIBLE, FOODTYPE.ROUGHAGE}
    if item ~= nil and item.components.edible ~= nil then
        for i, v in ipairs(testvalues) do
            if type(v) == "table" then
                for i2, v2 in ipairs(v.types) do
                    if item:HasTag("edible_"..v2) then
                        return true
                    end
                end
            elseif item:HasTag("edible_"..v) then
                return true
            end
        end
    end
end

local function tryDissolveItem(inst) -- Consume an edible item randomly from inventory

	inst:DoTaskInTime(math.random(400, 700)/10, tryDissolveItem)

	if inst:HasTag("playerghost") then return end
	local edibleitems = {}

	for slot, item in pairs(inst.components.inventory.itemslots) do
		if item.components.edible and item.components.inventoryitem:IsWet() and CanDissolve(item) then table.insert(edibleitems, item) end
	end
	for slot, item in pairs(inst.components.inventory.equipslots) do
		if item.components.edible and item.components.inventoryitem:IsWet() and CanDissolve(item) then table.insert(edibleitems, item) end
	end
	if inst.components.inventory.activeitem ~= nil then
		local item = inst.components.inventory:GetActiveItem()
		if item.components.edible and item.components.inventoryitem:IsWet() and CanDissolve(item) then table.insert(edibleitems, item) end
	end

	if #edibleitems > 0 then
		local item = edibleitems[math.random(#edibleitems)]
		inst.components.health:DoDelta(math.max(item.components.edible:GetHealth(inst) * inst.components.eater.healthabsorption, 0))
		inst.components.hunger:DoDelta(math.max(item.components.edible:GetHunger(inst) * inst.components.eater.hungerabsorption, 0))
		inst.components.sanity:DoDelta(item.components.edible:GetSanity(inst) * inst.components.eater.sanityabsorption, 0)
		item.components.edible:OnEaten(inst)
		local rot = nil
		if item.components.perishable and item.components.perishable.onperishreplacement and math.random() <= .04 then
			rot = SpawnPrefab(item.components.perishable.onperishreplacement)
		end
		inst.components.inventory:ConsumeByName(item.prefab, 1)
		if rot ~= nil then inst.components.inventory:GiveItem(rot) end
	end
end


local function temperatureDelta(inst)
	if inst:HasTag("playerghost") then return end
	if inst.components.temperature == nil then return end

	if inst.components.temperature:GetCurrent() <= 0 then -- Slowdown and "turning into ice" while freezing.
		if not inst:HasTag("groggy") then
			inst:AddTag("groggy")
			if inst.components.locomotor ~= nil then
				inst.components.locomotor:SetExternalSpeedMultiplier(inst, "grogginess", TUNING.MAX_GROGGY_SPEED_MOD)
			end
		end
		if inst.components.freezable and math.random() <= .01 then
			inst.components.freezable:AddColdness(1, TUNING.PLAYER_FREEZE_WEAR_OFF_TIME, false)
		end
	elseif inst.components.temperature:GetCurrent() > 0 and inst:HasTag("groggy") then
		inst:RemoveTag("groggy")
		if inst.components.locomotor ~= nil then
			inst.components.locomotor:RemoveExternalSpeedMultiplier(inst, "grogginess")
		end
	end

	if inst.components.hunger then
		if inst.components.temperature:GetCurrent() >= 70 then inst.components.hunger.hungerrate = 1.25 -- Increase hunger while overheating
		elseif inst.components.temperature:GetCurrent() <= 0 then inst.components.hunger.hungerrate = 0
		else inst.components.hunger.hungerrate = TUNING.WILSON_HUNGER_RATE end
	end
end


local function sanityDelta(inst) -- Regenerate health while sanity is above 100
	if inst:HasTag("playerghost") then return end
	if inst.components.sanity == nil then return end

	if not inst:HasTag("ghamaleeon_comfy") and inst.components.sanity.current >= (inst.components.sanity.max*2)/3 then
		inst:AddTag("ghamaleeon_comfy")
		inst.components.health:AddRegenSource(inst, 1, TUNING.TOTAL_DAY_TIME/25, "ghamaleeon_comfy")
	elseif inst:HasTag("ghamaleeon_comfy") and inst.components.sanity.current < (inst.components.sanity.max*2)/3 then
		inst:RemoveTag("ghamaleeon_comfy")
		inst.components.health:RemoveRegenSource(inst, "ghamaleeon_comfy")
	end
end


local function onPickaxeCombat(inst)
	local item = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
	if math.random() <= .8 then item.components.finiteuses:Repair(1) end
end

local function onEquip(inst, data)
	if data.item and data.item.components.tool and data.item.components.tool:CanDoAction(ACTIONS.MINE) then
		inst.components.combat.damagemultiplier = 1.25
		if data.item.components.finiteuses then inst:ListenForEvent("onhitother", onPickaxeCombat) end
	end
end

local function onUnequip(inst, data)
	if data.item and data.item.components.tool and data.item.components.tool:CanDoAction(ACTIONS.MINE) then
		inst.components.combat.damagemultiplier = 1
		if data.item.components.finiteuses then inst:RemoveEventCallback("onhitother", onPickaxeCombat) end
	end
end


local common_postinit = function(inst) 
	inst:AddTag("ghamaleeon_builder") -- Can build items with this tag
	inst:AddTag("shadowminion") -- Immunity to spiky plants, couldn't find any better way to implement this (I tried a lot)
	inst:AddTag("playermonster") -- I guess he's a monster?
    inst:AddTag("monster")
	inst.MiniMapEntity:SetIcon("ghamaleeon.tex")
end

local master_postinit = function(inst)
	inst.starting_inventory = start_inv[TheNet:GetServerGameMode()] or start_inv.default

	inst.soundsname = "ghamaleeon"
	inst.customidleanim = "idle_wilson"
	inst.components.talker.Say = function() end -- Can't talk

	inst.components.health:SetMaxHealth(TUNING.GHAMALEEON_HEALTH)
	inst.components.hunger:SetMax(TUNING.GHAMALEEON_HUNGER)
	inst.components.sanity:SetMax(TUNING.GHAMALEEON_SANITY)
	inst.components.hunger.hungerrate = TUNING.WILSON_HUNGER_RATE

	-- Can't eat anything normally, can't heal from food
	if inst.components.eater ~= nil then
		inst.components.eater:SetDiet({}, {})
		inst.components.eater:SetAbsorptionModifiers(0, 1, 1)
	end
	inst.components.health.canheal = false -- Can't use healing items

	-- Watermelon affinities, some day try frozen watermelon, you may like it!
    inst.components.foodaffinity:AddPrefabAffinity("watermelon", TUNING.AFFINITY_15_CALORIES_SMALL)
	inst.components.foodaffinity:AddPrefabAffinity("watermelonicle", TUNING.AFFINITY_15_CALORIES_SMALL)

	-- No penalty for being wet, always wet
	inst.components.temperature.maxmoisturepenalty = 0
	inst.components.sanity.no_moisture_penalty = true
	if inst.components.moisture ~= nil then
		inst.components.moisture.GetMoistureRate = function() return 100 end
	end

	inst.components.health.fire_damage_scale = 0 -- No damage from fire
	inst.components.temperature.hurtrate = 0 -- No damage from temperature

	-- "Weakness" to both temperatures.
	inst.components.temperature.inherentinsulation = -TUNING.INSULATION_SMALL
    inst.components.temperature.inherentsummerinsulation = -TUNING.INSULATION_TINY

	inst.AnimState:SetScale(0.98, 0.98, 0.98) -- A little bit smaller than an average character

	-- inst.components.builder:UnlockRecipe("")

	inst:DoTaskInTime(math.random(400, 700)/10, tryDissolveItem) -- Start dissolve cycle
	inst:ListenForEvent("temperaturedelta", temperatureDelta) -- Custom temperature interactions
	inst:ListenForEvent("sanitydelta", sanityDelta) -- Sanity triggers health regen
	inst:ListenForEvent("equip", onEquip)
	inst:ListenForEvent("unequip", onUnequip)
end

return MakePlayerCharacter("ghamaleeon", prefabs, assets, common_postinit, master_postinit, prefabs)
