if not REPENTANCE then return end

ASSORTEDTRINKETS = RegisterMod("Assorted Trinkets", 1)


function ASSORTEDTRINKETS:Data(entity)
	local data = entity:GetData()
	if data.AssortedData == nil then data.AssortedData = {} end
	return data.AssortedData
end


function ASSORTEDTRINKETS:GetPlayers(toPairs)
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


include("trinkets.inner_void")
include("trinkets.bullet_heaven")
include("trinkets.purple_sparks")
include("trinkets.hot_potato")
include("trinkets.spare_button")
include("trinkets.secret_spice")
