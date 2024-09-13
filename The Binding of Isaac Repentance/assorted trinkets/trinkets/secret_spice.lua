local secretspice = {}

local SECRETSPICE = Isaac.GetTrinketIdByName("Secret Spice")


function secretspice:OnNewFloor()
	for _, player in ASSORTEDTRINKETS:GetPlayers() do
		if player:GetTrinketMultiplier(SECRETSPICE) == 1 then
			player:UseActiveItem(CollectibleType.COLLECTIBLE_SMELTER, false)
		end
	end
end ASSORTEDTRINKETS:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, secretspice.OnNewFloor)


function secretspice:OnPeffect(player)
	if player:GetTrinketMultiplier(SECRETSPICE) < 2 then return end
	if player.QueuedItem.Item and player.QueuedItem.Item.Type == ItemType.ITEM_TRINKET then
		player:FlushQueueItem()
		player:UseActiveItem(CollectibleType.COLLECTIBLE_SMELTER, false)
	end
end ASSORTEDTRINKETS:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, secretspice.OnPeffect)


if EID then
	EID:setModIndicatorName("Secret Spice")
	EID:setModIndicatorIcon("Trinket"..SECRETSPICE.."")

	EID:addTrinket(SECRETSPICE,
	"Reaching a new floor gulps all held trinkets"
	)
	EID:addGoldenTrinketMetadata(SECRETSPICE,
		"{{TreasureRoom}} Gulps trinkets upon touching them"
	)
end
