local tgamma = {}

local gammaType = Isaac.GetPlayerTypeByName("Gamma", true)
local gammaCostume = Isaac.GetCostumeIdByPath("gfx/characters/gamma.anm2")

local game = Game()
local itemPool = game:GetItemPool()

local Stats = {
	Speed = 0.3,
	MaxFireDelay = 1.6,
	Damage = 1.2,
	TearRange = -1.5,
	ShotSpeed = -0.15,
	Luck = -2,
	TearColor = Color(0.4, 1.0, 0.46, 1, 0, 0, 0),
}

local shapeTime = {
	[1] = 8, -- 1x1
	[2] = 8, -- Horizontal Narrow 1x1
	[3] = 8, -- Vertical Narrow 1x1
	[4] = 12, -- Vertical 1x2
	[5] = 12, -- Vertical Narrow 1x2
	[6] = 12, -- Horizontal 1x2
	[7] = 12, -- Horizontal Narrow 1x2
	[8] = 16, -- 2x2
	[9] = 16, -- J Shape
	[10] = 16, -- L Shape
	[11] = 16, -- Reverse r Shape
	[12] = 16, -- r Shape
}


local function DecrementTime()

	local room = game:GetRoom()

	if (room:GetType() == 11 or room:GetType() == 17)
	and not room:IsAmbushDone() then game.TimeCounter = math.max(game.TimeCounter - 1, 0)
	else game.TimeCounter = math.max(game.TimeCounter - 2, 0) end

	if game.TimeCounter == 0 then
		for _, player in GammaMod:GetPlayers() do
			if player:GetPlayerType() == gammaType then
				player:Die()
				if player:WillPlayerRevive() then game.TimeCounter = 32*30 end
			end
		end
	end
end


local function applyLevelTime()
	local level = game:GetLevel()

	local levelTime = 0

	local rooms = level:GetRooms()
	for i = 1, rooms.Size - 1 do
		local room = rooms:Get(i)
		levelTime = levelTime + (30)*shapeTime[room.Data.Shape]
	end

	game.TimeCounter = levelTime
end


function tgamma:OnFrame()
	for _, player in GammaMod:GetPlayers() do
		if player:GetPlayerType() == gammaType then return DecrementTime() end
	end
end GammaMod:AddCallback(ModCallbacks.MC_POST_UPDATE, tgamma.OnFrame)


function tgamma:OnPeffect(player)
	if player:GetPlayerType() ~= gammaType then return end
	local data = GammaMod:Data(player)
	if data["GammaFirstFrame"] == nil then
		data["GammaFirstFrame"] = true
		player:AddBoneHearts(1)
		player:AddMaxHearts(-2)
		player:AddNullCostume(gammaCostume)
		itemPool:RemoveTrinket(TrinketType.TRINKET_CALLUS)
		player:AddTrinket(TrinketType.TRINKET_CALLUS)
		player:UseActiveItem(CollectibleType.COLLECTIBLE_SMELTER, false)
	end

	GammaMod:HeartsToSoul(player)

end GammaMod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, tgamma.OnPeffect)


function tgamma:OnNewFloor()

	for _, player in GammaMod:GetPlayers() do
		if player:GetPlayerType() == gammaType then return applyLevelTime() end
	end

end GammaMod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, tgamma.OnNewFloor)


function tgamma:OnCache(player, cacheFlag)
	if player:GetPlayerType() ~= gammaType then return end
	
	if cacheFlag == CacheFlag.CACHE_SPEED then player.MoveSpeed = player.MoveSpeed + Stats.Speed end
	if cacheFlag == CacheFlag.CACHE_FIREDELAY then player.MaxFireDelay = player.MaxFireDelay/Stats.MaxFireDelay end
	if cacheFlag == CacheFlag.CACHE_DAMAGE then player.Damage = player.Damage*Stats.Damage end
	if cacheFlag == CacheFlag.CACHE_RANGE then player.TearRange = player.TearRange + (Stats.TearRange * 40) end
	if cacheFlag == CacheFlag.CACHE_SHOTSPEED then player.ShotSpeed = player.ShotSpeed + Stats.ShotSpeed end
	if cacheFlag == CacheFlag.CACHE_LUCK then player.Luck = player.Luck + Stats.Luck end
	
	if cacheFlag == CacheFlag.CACHE_TEARCOLOR then player.TearColor = Stats.TearColor end
	
end GammaMod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, tgamma.OnCache)
