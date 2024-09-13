local spareButton = {}

local SPAREBUTTON = Isaac.GetTrinketIdByName("Spare Button")


function spareButton:OnFrame()
	if Game():GetRoom():GetFrameCount() % 60 ~= 0 then return end

	local totalMult = 0
	local player = Isaac.GetPlayer(0)
	for _, player in ASSORTEDTRINKETS:GetPlayers() do
		totalMult = totalMult + player:GetTrinketMultiplier(SPAREBUTTON)
	end if totalMult <= 0 then return end

	for _, entity in pairs(Isaac.GetRoomEntities()) do
		if entity:IsActiveEnemy() and not entity:IsBoss() and not entity:HasEntityFlags(EntityFlag.FLAG_FRIENDLY|EntityFlag.FLAG_ICE_FROZEN) then
			if not entity:HasFullHealth() and player:GetTrinketRNG(SPAREBUTTON):RandomFloat() <= (1/15) * totalMult then
				Game():SpawnParticles(entity.Position, EffectVariant.POOF01, 1, 0)
				entity:Remove()
			elseif entity:HasFullHealth() and player:GetTrinketRNG(SPAREBUTTON):RandomFloat() <= (1/60) * totalMult then
				Game():SpawnParticles(entity.Position, EffectVariant.GROUND_GLOW, 1, 0)
				entity:AddCharmed(EntityRef(player), -1)
			end
		end
	end
	
end ASSORTEDTRINKETS:AddCallback(ModCallbacks.MC_POST_UPDATE, spareButton.OnFrame)


if EID then
	EID:setModIndicatorName("Spare Button")
	EID:setModIndicatorIcon("Trinket"..SPAREBUTTON.."")

	EID:addTrinket(SPAREBUTTON,
	"Damaged enemies have a ~6.6% chance to be spared each second"..
	"#{{Charm}} Full health enemies have a ~1.6% chance to become friendly instead"..
	"#{{Warning}} Doesn't work on bosses"
	)
	EID:addGoldenTrinketMetadata(SPAREBUTTON,
		"{{TreasureRoom}} Chances doubled"
	)
end
