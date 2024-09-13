local gamma = {}

local gammaType = Isaac.GetPlayerTypeByName("Gamma", false)
local gammaCostume = Isaac.GetCostumeIdByPath("gfx/characters/gamma.anm2")


local Stats = {
	Speed = 0.15,
	MaxFireDelay = 0,
	Damage = 0,
	TearRange = -1.5,
	ShotSpeed = -0.15,
	Luck = 0,
	TearColor = Color(0.4, 1.0, 0.46, 1, 0, 0, 0),
}


function gamma:OnNewFloor()
	for _, player in GammaMod:GetPlayers() do
		if player:GetPlayerType() == gammaType then
			player:UseActiveItem(CollectibleType.COLLECTIBLE_SMELTER, false)
		end
	end
end GammaMod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, gamma.OnNewFloor)


local function ActivesToTrinkets(player)
	if not player.QueuedItem.Item then return end

	if player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT)
	and player.QueuedItem.Item.Type == ItemType.ITEM_TRINKET then
		GammaMod:GiveSmeltedTrinket(player, player.QueuedItem.Item.ID)
		player:FlushQueueItem()
		return
	end

	if player.QueuedItem.Item.Type == ItemType.ITEM_ACTIVE
	or (player.QueuedItem.Item.ID == 584 and player.QueuedItem.Item.Type == ItemType.ITEM_PASSIVE) then

		local itemID = player.QueuedItem.Item.ID
		player:FlushQueueItem()
		player:RemoveCollectible(itemID)

		GammaMod:GiveSmeltedTrinket(player, Game():GetItemPool():GetTrinket())
	end
end


function gamma:OnPeffect(player)
	if player:GetPlayerType() ~= gammaType then return end

	local data = GammaMod:Data(player)
	if data["GammaFirstFrame"] == nil then
		data["GammaFirstFrame"] = true
		player:AddBoneHearts(1)
		player:AddMaxHearts(-2)
		player:AddNullCostume(gammaCostume)
		Game():GetItemPool():RemoveTrinket(TrinketType.TRINKET_CALLUS)
		player:AddTrinket(TrinketType.TRINKET_CALLUS)
		player:UseActiveItem(CollectibleType.COLLECTIBLE_SMELTER, false)
	end

	ActivesToTrinkets(player)
	GammaMod:HeartsToSoul(player)

end GammaMod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, gamma.OnPeffect)


function gamma:OnCache(player, cacheFlag)
	if player:GetPlayerType() ~= gammaType then return end

	if cacheFlag == CacheFlag.CACHE_SPEED then player.MoveSpeed = player.MoveSpeed + Stats.Speed end
	if cacheFlag == CacheFlag.CACHE_FIREDELAY then player.MaxFireDelay = GammaMod:TearsUp(player.MaxFireDelay, Stats.MaxFireDelay) end
	if cacheFlag == CacheFlag.CACHE_DAMAGE then player.Damage = player.Damage + Stats.Damage end
	if cacheFlag == CacheFlag.CACHE_RANGE then player.TearRange = player.TearRange + (Stats.TearRange * 40) end
	if cacheFlag == CacheFlag.CACHE_SHOTSPEED then player.ShotSpeed = player.ShotSpeed + Stats.ShotSpeed end
	if cacheFlag == CacheFlag.CACHE_LUCK then player.Luck = player.Luck + Stats.Luck end

	if cacheFlag == CacheFlag.CACHE_TEARCOLOR then player.TearColor = Stats.TearColor end
	
end GammaMod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, gamma.OnCache)