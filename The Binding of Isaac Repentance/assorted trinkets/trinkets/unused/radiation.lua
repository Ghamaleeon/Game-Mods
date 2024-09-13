local radiation = {}

local game = Game()

local radiationItem = Isaac.GetItemIdByName("Radiation")

local radiationDelay = 0

function radiation:OnPeffect(player)
	if not player:HasCollectible(radiationItem) then return end
	
	if radiationDelay > -1 then radiationDelay = radiationDelay - 1 end

	local entities = Isaac.GetRoomEntities()
	if not (next(entities) == nil and radiationDelay <= 0) then return end
	
	local enemyAmount = 0
	for _, entity in ipairs(entities) do
		if entity:IsActiveEnemy() and entity:IsVulnerableEnemy() then enemyAmount = enemyAmount + 1 end
	end
	for _, entity in ipairs(entities) do
		if entity:IsActiveEnemy() and entity:IsVulnerableEnemy() then
			entity:TakeDamage(player.Damage/(enemyAmount*5), 0, EntityRef(player), 0)
		end
	end
end
GammaMod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, radiation.OnPeffect)
