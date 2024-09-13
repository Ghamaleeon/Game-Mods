local gamma = {}

local gammaType = Isaac.GetPlayerTypeByName("Gamma", false)
local gammaCostume = Isaac.GetCostumeIdByPath("gfx/characters/gamma.anm2")

local game = Game()
local itemPool = game:GetItemPool()

local Stats = {
	Speed = 0.15,
	MaxFireDelay = 0,
	Damage = 0,
	TearRange = -1.5,
	ShotSpeed = -0.15,
	Luck = 0,
	TearColor = Color(0.4, 1.0, 0.46, 1, 0, 0, 0),
}


local function RemoveActives(player)
	if not (player.QueuedItem.Item
	and (player.QueuedItem.Item.Type == ItemType.ITEM_ACTIVE
	or (player.QueuedItem.Item.ID == 584
	and player.QueuedItem.Item.Type == ItemType.ITEM_PASSIVE))) then return end
	local itemID = player.QueuedItem.Item.ID
	player:FlushQueueItem()
	player:RemoveCollectible(itemID)
	local trinketID = itemPool:GetTrinket()

	local heldTrinket = player:GetTrinket(0)
	if not (heldTrinket == 0 or heldTrinket == nil) then
		player:TryRemoveTrinket(heldTrinket)
	end

	local heldTrinket2 = player:GetTrinket(0)
	if not (heldTrinket2 == 0 or heldTrinket2 == nil) then
		player:TryRemoveTrinket(heldTrinket2)
	end

	player:AddTrinket(trinketID)
	player:UseActiveItem(CollectibleType.COLLECTIBLE_SMELTER, false)

	if not (heldTrinket == 0 or heldTrinket == nil) then
		player:AddTrinket(heldTrinket)
	end

	if not (heldTrinket2 == 0 or heldTrinket2 == nil) then
		player:AddTrinket(heldTrinket2)
	end

	player:AnimateTrinket(trinketID)
	game:GetHUD():ShowItemText(player, Isaac:GetItemConfig():GetTrinket(trinketID))
end


local function RemoveRedHearts(player)
	if player:GetHearts() > 0
	and not player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) then
		player:AddHearts(-player:GetHearts())
		if player:GetSoulHearts() + player:GetEternalHearts() <= 0 then player:AddSoulHearts(2) end
	end
	if player:GetMaxHearts() > 12 then
		player:AddMaxHearts(-2)
		player:AddSoulHearts(2)
	end

	if game:GetFrameCount() % 1800 == 0 then
		if player:GetBoneHearts() ~= 0 then player:AddBoneHearts(-1)
		else player:AddMaxHearts(-2) end
	end

	if player:GetEffectiveMaxHearts() <= 0 then player:Die() end
end


function gamma:OnNewFloor()
	for _, player in GammaMod:GetPlayers() do
		if player:GetPlayerType() == gammaType and (player:GetTrinket(0) ~= 0 or player:GetTrinket(1) ~= 0) then
			for slot=0, 1 do
				if player:GetTrinket(slot) ~= 0 then
					player:AddBoneHearts(1)
					player:AddHearts(2)
				end
			end
			player:UseActiveItem(CollectibleType.COLLECTIBLE_SMELTER, false)
		end
	end
end GammaMod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, gamma.OnNewFloor)


function gamma:OnPeffect(player)

	local data = GammaMod:Data(player)
	if player:GetPlayerType() ~= gammaType then return end

	if data["GammaFirstFrame"] == nil then
		data["GammaFirstFrame"] = true
		if player:GetPlayerType() == gammaType then
			player:AddBoneHearts(1)
			player:AddHearts(2)
		end

		if not player:HasTrinket(TrinketType.TRINKET_CALLUS) then
			player:AddNullCostume(gammaCostume)
			itemPool:RemoveTrinket(TrinketType.TRINKET_CALLUS)
			player:AddTrinket(TrinketType.TRINKET_CALLUS)
			player:UseActiveItem(CollectibleType.COLLECTIBLE_SMELTER, false)
		end
	end

	RemoveActives(player)

	if data["BoneHearts"] == nil then data["BoneHearts"] = player:GetBoneHearts()
	else data["BoneHearts"] = math.max(data["BoneHearts"], player:GetBoneHearts()) end

	if data["BoneHearts"] == 0 and (player:GetMaxHearts() > 0 or player:GetSoulHearts() == 1) then
		player:AddBoneHearts(1)
		player:AddHearts(2)
	end

	if player:GetMaxHearts() > 0 then
		local recover = player:GetMaxHearts()
		player:AddMaxHearts(-player:GetMaxHearts())
		if player:GetBoneHearts() < data["BoneHearts"] then player:AddBoneHearts(data["BoneHearts"] - player:GetBoneHearts()) end
		player:AddHearts(recover)
	end
	if player:GetSoulHearts() > 0 then player:AddSoulHearts(-player:GetSoulHearts()) end

	data["BoneHearts"] = player:GetBoneHearts()

	if (player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT))
	and (player:GetTrinket(0) ~= 0 or player:GetTrinket(1) ~= 0) then
		player:UseActiveItem(CollectibleType.COLLECTIBLE_SMELTER, false)
	end

end GammaMod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, gamma.OnPeffect)


function gamma:OnHeartCollision(heart, player, _)
	if player.Type ~= EntityType.ENTITY_PLAYER then return end
	player = player:ToPlayer()
	if player:GetPlayerType() ~= gammaType then return end
	if heart.Price ~= 0 then return end
	if heart.SubType == 3 or heart.SubType == 6 or heart.SubType == 8 then return false end
end GammaMod:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, gamma.OnHeartCollision, PickupVariant.PICKUP_HEART)


function gamma:OnCache(player, cacheFlag)
	if player:GetPlayerType() == gammaType then
		if cacheFlag == CacheFlag.CACHE_SPEED then player.MoveSpeed = player.MoveSpeed + Stats.Speed end
		if cacheFlag == CacheFlag.CACHE_FIREDELAY then player.MaxFireDelay = GammaMod:TearsUp(player.MaxFireDelay, Stats.MaxFireDelay) end
		if cacheFlag == CacheFlag.CACHE_DAMAGE then player.Damage = player.Damage + Stats.Damage end
		if cacheFlag == CacheFlag.CACHE_RANGE then player.TearRange = player.TearRange + (Stats.TearRange * 40) end
		if cacheFlag == CacheFlag.CACHE_SHOTSPEED then player.ShotSpeed = player.ShotSpeed + Stats.ShotSpeed end
		if cacheFlag == CacheFlag.CACHE_LUCK then player.Luck = player.Luck + Stats.Luck end

		if cacheFlag == CacheFlag.CACHE_TEARCOLOR then player.TearColor = Stats.TearColor end
	end
end GammaMod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, gamma.OnCache)
