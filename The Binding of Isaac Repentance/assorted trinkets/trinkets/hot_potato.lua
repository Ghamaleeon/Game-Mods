local hotPotato = {}

local HOTPOTATO = Isaac.GetTrinketIdByName("Hot Potato")


function hotPotato:OnNPCDeath(entityNPC)
	local totalMult = 0
	local player = Isaac.GetPlayer(0)
	for _, player in ASSORTEDTRINKETS:GetPlayers() do
		totalMult = totalMult + player:GetTrinketMultiplier(HOTPOTATO)
	end if totalMult <= 0 then return end

	if player:GetTrinketRNG(HOTPOTATO):RandomFloat() <= 0.05 * totalMult then
		local bomb = Isaac.Spawn(EntityType.ENTITY_PICKUP,41,0,entityNPC.Position,Vector(0,0),nil)
		bomb:ToPickup().Timeout = 60
	end

end ASSORTEDTRINKETS:AddCallback(ModCallbacks.MC_POST_NPC_DEATH, hotPotato.OnNPCDeath)

if EID then
	EID:setModIndicatorName("Hot Potato")
	EID:setModIndicatorIcon("Trinket"..HOTPOTATO.."")

	EID:addTrinket(HOTPOTATO,
	"Killed enemies have a 5% chance to drop a red bomb"..
	"#The red bomb disappears after 1 second"
	)
	EID:addGoldenTrinketMetadata(HOTPOTATO,
		"{{TreasureRoom}} Drop chance doubled"
	)
end