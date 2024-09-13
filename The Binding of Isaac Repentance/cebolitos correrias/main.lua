CEBOLITOS = RegisterMod("Cebolitos Correrias",1)
local cebolitos = {}


local desafios = {
	[Isaac.GetChallengeIdByName("Cebolitos Correrias")] = "Cebolitos Correrias",
	[Isaac.GetChallengeIdByName("Perdido Pisadinhas")] = "Perdido Pisadinhas",
	[Isaac.GetChallengeIdByName("Burguesias Bolonhesa")] = "Burguesias Bolonhesa",
	[Isaac.GetChallengeIdByName("Madalena Muqueteira")] = "Madalena Muqueteira",
}


function cebolitos.RodarAtivos(_,collectible,pool,_,seed)
	if desafios[Isaac.GetChallenge()] == nil then return end
	if pool == ItemPoolType.POOL_LIBRARY then return end

	if Isaac.GetItemConfig():GetCollectible(collectible).Type == ItemType.ITEM_ACTIVE then
		collectible = Game():GetItemPool():GetCollectible(pool,true,seed)
	end

	return collectible
end CEBOLITOS:AddCallback(ModCallbacks.MC_POST_GET_COLLECTIBLE, cebolitos.RodarAtivos)


function cebolitos:RemoverAtivos(collectible, player, _)
	if desafios[Isaac.GetChallenge()] == nil then return end
	if player.Type ~= EntityType.ENTITY_PLAYER then return end
	player = player:ToPlayer()
	if collectible.SubType == 0 or Isaac:GetItemConfig():GetCollectible(collectible.SubType).Type ~= ItemType.ITEM_ACTIVE then return end

	player:AnimateSad()
	Game():SpawnParticles(collectible.Position, EffectVariant.POOF01, 1, 0)
	collectible:Remove()

	return true
end CEBOLITOS:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, cebolitos.RemoverAtivos, PickupVariant.PICKUP_COLLECTIBLE)


function cebolitos:InstaBaconzitos(player)
	if not player:IsExtraAnimationFinished() or player:GetData().espera == nil then return end
	player:GetData().espera = nil

	player:UseActiveItem(CollectibleType.COLLECTIBLE_ANIMA_SOLA, false)

end CEBOLITOS:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, cebolitos.InstaBaconzitos)


function cebolitos:Espera()
	if desafios[Isaac.GetChallenge()] ~= "Cebolitos Correrias" then return end

	local playerCount = Game():GetNumPlayers()
	for playerIndex = 0, playerCount - 1 do
		local player = Isaac.GetPlayer(playerIndex)
		player:GetData().espera = true
	end

end
CEBOLITOS:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, cebolitos.Espera)
