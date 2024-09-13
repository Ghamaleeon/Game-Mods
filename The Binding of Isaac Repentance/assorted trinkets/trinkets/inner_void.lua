local innerVoid = {}

local INNERVOID = Isaac.GetTrinketIdByName("Inner Void")
local INNERVOIDDMG = 0.025


function innerVoid:OnNewFloor()

	local totalMult = 0
	local player = Isaac.GetPlayer(0)
	for _, player in ASSORTEDTRINKETS:GetPlayers() do
		totalMult = totalMult + player:GetTrinketMultiplier(INNERVOID)
	end if totalMult <= 0 then return end

	local totalConsumed = 0
	if player:GetNumCoins() > 0 then
		local removeAmount = math.ceil(player:GetNumCoins()/2)
		player:AddCoins(-removeAmount)
		totalConsumed = totalConsumed + removeAmount
	end
	if player:GetNumBombs() > 0 then
		local removeAmount = math.ceil(player:GetNumBombs()/2)
		player:AddBombs(-removeAmount)
		totalConsumed = totalConsumed + removeAmount
	end
	if player:GetNumKeys() > 0 then
		local removeAmount = math.ceil(player:GetNumKeys()/2)
		player:AddKeys(-removeAmount)
		totalConsumed = totalConsumed + removeAmount
	end

	for _, player in ASSORTEDTRINKETS:GetPlayers() do
		local data = ASSORTEDTRINKETS:Data(player)
		if data["InnerVoid"] == nil then data["InnerVoid"] = 0 end
		data["InnerVoid"] = data["InnerVoid"] + (totalConsumed*totalMult)
		player:AddCacheFlags(CacheFlag.CACHE_DAMAGE)
		player:EvaluateItems()
	end
end ASSORTEDTRINKETS:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, innerVoid.OnNewFloor)


function innerVoid:OnCache(player, cacheFlag)
	local data = ASSORTEDTRINKETS:Data(player)
	if data["InnerVoid"] ~= nil and cacheFlag == CacheFlag.CACHE_DAMAGE then player.Damage = player.Damage + data["InnerVoid"]*INNERVOIDDMG end
end ASSORTEDTRINKETS:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, innerVoid.OnCache)


if EID then
	EID:setModIndicatorName("Inner Void")
	EID:setModIndicatorIcon("Trinket"..INNERVOID.."")

	EID:addTrinket(INNERVOID,
	"{{Warning}} Changing floors consumes half of your pickups"..
	"#↑  {{Damage}} +0.025 Permanent damage for all players per pickup consumed"
	)
	EID:addGoldenTrinketMetadata(INNERVOID,
		"{{TreasureRoom}} Damage increase doubled"
	)
end