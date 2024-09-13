local scuffedCap = {}

local SCUFFEDCAP = Isaac.GetTrinketIdByName("Scuffed Cap")


function scuffedCap:OnRoomReward(_, _)
	local totalMult = 0
	local player = Isaac.GetPlayer(0)
	for _, player in ASSORTEDTRINKETS:GetPlayers() do
		totalMult = totalMult + player:GetTrinketMultiplier(SCUFFEDCAP)
	end if totalMult <= 0 then return end

	for _=1, totalMult do player:UseActiveItem(582, false) end
	for _, player in ASSORTEDTRINKETS:GetPlayers() do
		if player:GetTrinketRNG(SCUFFEDCAP):RandomFloat() <= 0.1 * totalMult then player:UseActiveItem(83, false) end
		if player:GetTrinketRNG(SCUFFEDCAP):RandomFloat() <= 0.4 * totalMult then player:UseActiveItem(36, false) end
	end

end ASSORTEDTRINKETS:AddCallback(ModCallbacks.MC_PRE_SPAWN_CLEAN_AWARD, scuffedCap.OnRoomReward)

if EID then
	EID:setModIndicatorName("Scuffed Cap")
	EID:setModIndicatorIcon("Trinket"..SCUFFEDCAP.."")

	EID:addTrinket(SCUFFEDCAP,
	"Upon room completion:"..
	"#{{Collectible582}} Applies Wavy Cap effect"..
	"#{{Collectible36}} 40% chance to spawn a poop"..
	"#{{Collectible83}} 10% chance to apply The Nail effect"
	)
	EID:addGoldenTrinketMetadata(SCUFFEDCAP,
		"{{TreasureRoom}} Double wavy cap, double chances"
	)
end
