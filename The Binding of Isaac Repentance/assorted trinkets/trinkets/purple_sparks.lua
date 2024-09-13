local purpleSparks = {}

local PURPLESPARKS = Isaac.GetTrinketIdByName("Purple Sparks")

function purpleSparks:OnNewFloor()
	for _, player in ASSORTEDTRINKETS:GetPlayers() do
		if player:HasTrinket(PURPLESPARKS) and player:GetTrinketRNG(PURPLESPARKS):RandomFloat() <= 1/3 then
			for _=1, 2 * player:GetTrinketMultiplier(PURPLESPARKS) do
				player:UseActiveItem(CollectibleType.COLLECTIBLE_LEMEGETON, false)
			end
			for _=1, player:GetTrinketMultiplier(PURPLESPARKS) do
				player:TryRemoveTrinket(PURPLESPARKS)
			end
			SFXManager():Play(SoundEffect.SOUND_FIREDEATH_HISS)
		end
	end
end ASSORTEDTRINKETS:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, purpleSparks.OnNewFloor)

if EID then
	EID:setModIndicatorName("Purple Sparks")
	EID:setModIndicatorIcon("Trinket"..PURPLESPARKS.."")

	EID:addTrinket(PURPLESPARKS,
	"{{Collectible712}} Changing floors has a ~33.3% chance to give 2 item wisps, destroys itself upon doing so"
	)
	EID:addGoldenTrinketMetadata(PURPLESPARKS,
		"{{TreasureRoom}} Item wisps doubled"
	)
end