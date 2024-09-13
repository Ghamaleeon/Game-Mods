if not REPENTANCE then return end

GammaMod = RegisterMod("gamma", 1)


function GammaMod:Data(entity)
	local data = entity:GetData()
	if data.GammaData == nil then data.GammaData = {} end
	return data.GammaData
end


function GammaMod:GetPlayers(toPairs)
	local playerCount = Game():GetNumPlayers()
	local players = {}
	for playerIndex = 0, playerCount - 1 do
		local player = Isaac.GetPlayer(playerIndex)
		table.insert(players, player)
	end
	if toPairs == nil then toPairs = true end
	if toPairs then return pairs(players)
	else return players end
end


function GammaMod:TearsUp(firedelay, val)
	local currentTears = 30 / (firedelay + 1)
	local newTears = currentTears + val
	return math.max((30 / newTears) - 1, -0.9999)
end


function GammaMod:GiveSmeltedTrinket(player, trinket)

	local heldTrinket = player:GetTrinket(0)
	if not (heldTrinket == 0 or heldTrinket == nil) then
		player:TryRemoveTrinket(heldTrinket)
	end

	local heldTrinket2 = player:GetTrinket(0)
	if not (heldTrinket2 == 0 or heldTrinket2 == nil) then
		player:TryRemoveTrinket(heldTrinket2)
	end

	player:AddTrinket(trinket)
	player:UseActiveItem(CollectibleType.COLLECTIBLE_SMELTER, false)

	if not (heldTrinket == 0 or heldTrinket == nil) then
		player:AddTrinket(heldTrinket)
	end

	if not (heldTrinket2 == 0 or heldTrinket2 == nil) then
		player:AddTrinket(heldTrinket2)
	end

	player:AnimateTrinket(trinket)
	Game():GetHUD():ShowItemText(player, Isaac:GetItemConfig():GetTrinket(trinket))

end


function GammaMod:HeartsToSoul(player)
	if player:GetMaxHearts() > 0 then
		local hearts = player:GetMaxHearts()
		player:AddMaxHearts(-hearts)
		player:AddSoulHearts(hearts)
	end
end


include("gamma_src.characters.gamma")
include("gamma_src.characters.t_gamma")
