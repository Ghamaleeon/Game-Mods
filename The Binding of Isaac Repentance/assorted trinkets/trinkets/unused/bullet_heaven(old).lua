local bulletHeaven = {}

local BULLETHEAVENTRINKET = Isaac.GetTrinketIdByName("Bullet Heaven")
local FLAG = ProjectileFlags
local FLAG_BLACKLIST = {FLAG.EXPLODE, FLAG.CONTINUUM}
local TEARDURATION = 7.5*60

function bulletHeaven:OnProjectileUpdate(projectile)
	local data = GammaMod:Data(projectile)
	if data["BulletHeaven"] ~= nil and data["BulletHeaven"] ~= -1 then
		projectile.Height = -23
		projectile.FallingAccel = 0
		projectile.FallingSpeed = 0
		data["BulletHeaven"] = data["BulletHeaven"] + 1
		if data["BulletHeaven"] >= TEARDURATION then
			projectile:Die()
		end
	end
	if data["BulletHeaven"] ~= nil then return end
	
	data["BulletHeaven"] = -1
	local playerCount = Game():GetNumPlayers()

	for playerIndex = 0, playerCount - 1 do
		local player = Isaac.GetPlayer(playerIndex)
		if player:HasTrinket(BULLETHEAVENTRINKET) then
			for _, each in pairs(FLAG_BLACKLIST) do
				if projectile:HasProjectileFlags(each) then return end
			end
			data["BulletHeaven"] = 0
			projectile.Velocity = projectile.Velocity*0.8
		end
	end
end
GammaMod:AddCallback(ModCallbacks.MC_POST_PROJECTILE_UPDATE, bulletHeaven.OnProjectileUpdate)

