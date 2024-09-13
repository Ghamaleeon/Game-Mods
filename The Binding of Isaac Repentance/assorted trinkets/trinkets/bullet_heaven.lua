local bulletHeaven = {}

local BULLETHEAVEN = Isaac.GetTrinketIdByName("Bullet from Heaven")


function bulletHeaven:OnProjectileInit(projectile)
	local totalMult = 0
	local player = Isaac.GetPlayer(0)
	for _, player in ASSORTEDTRINKETS:GetPlayers() do
		totalMult = totalMult + player:GetTrinketMultiplier(BULLETHEAVEN)
	end if totalMult <= 0 then return end

	projectile:AddProjectileFlags(ProjectileFlags.SLOWED)
	
	if player:GetTrinketRNG(BULLETHEAVEN):RandomFloat() <= 0.07 * (totalMult - 1) then projectile:Remove() end

end ASSORTEDTRINKETS:AddCallback(ModCallbacks.MC_POST_PROJECTILE_INIT, bulletHeaven.OnProjectileInit)

if EID then
	EID:setModIndicatorName("Bullet from Heaven")
	EID:setModIndicatorIcon("Trinket"..BULLETHEAVEN.."")

	EID:addTrinket(BULLETHEAVEN,
	"{{Slow}} Slows most enemy projectiles"
	)
	EID:addGoldenTrinketMetadata(BULLETHEAVEN,
		"{{TreasureRoom}} 7% chance for projectiles to don't spawn at all"
	)
end
