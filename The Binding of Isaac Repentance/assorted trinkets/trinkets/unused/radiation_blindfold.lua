local radiation = {}

local game = Game()
local activeBlindfold

local radiationItem = Isaac.GetItemIdByName("Radiation")

local function setBlindfold(player, enabled)
	local character = player:GetPlayerType()
	local challenge = Isaac.GetChallenge()

	if enabled then
		game.Challenge = Challenge.CHALLENGE_SOLAR_SYSTEM
		player:ChangePlayerType(character)
		game.Challenge = challenge
		player:AddNullCostume(NullItemID.ID_BLINDFOLD)
	else
		game.Challenge = Challenge.CHALLENGE_NULL
		player:ChangePlayerType(character)
		game.Challenge = challenge
		player:TryRemoveNullCostume(NullItemID.ID_BLINDFOLD)
	end
	activeBlindfold = enabled
end

function radiation:OnPeffect(player)
	if not player:HasCollectible(radiationItem) then
		if activeBlindfold then setBlindfold(player, false) end
		return
	end
	
	if not activeBlindfold then setBlindfold(player, true) end
	
	if player.FireDelay < 0 then
		local entities = Isaac.FindInRadius(player.Position, player.TearRange/3)
		local enemyAmount = 0
		for _, entity in ipairs(entities) do
			if entity:IsVulnerableEnemy() then enemyAmount = enemyAmount + 1 end
		end
		for _, entity in ipairs(entities) do
			if entity:IsActiveEnemy() and entity:IsVulnerableEnemy() then
				entity:TakeDamage(player.Damage/enemyAmount, 0, EntityRef(player), 0)
				player.FireDelay = player.MaxFireDelay
			end
		end
		local room = game:GetRoom()
		if enemyAmount <= 0 then
			room:DamageGrid(room:GetRandomTileIndex(Random()), math.ceil(player.Damage/5))
		end
	end
	
end
GammaMod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, radiation.OnPeffect)
