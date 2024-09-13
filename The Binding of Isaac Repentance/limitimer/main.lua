if not REPENTANCE then return end

LIMITIMER = RegisterMod("The Limitimer", 1)
local limitimer_item = Isaac.GetItemIdByName("The Limitimer")

local limitimer = {}


local shapeTime = {
	[1] = 7, -- 1x1
	[2] = 7, -- Horizontal Narrow 1x1
	[3] = 7, -- Vertical Narrow 1x1
	[4] = 10.5, -- Vertical 1x2
	[5] = 10.5, -- Vertical Narrow 1x2
	[6] = 10.5, -- Horizontal 1x2
	[7] = 10.5, -- Horizontal Narrow 1x2
	[8] = 14, -- 2x2
	[9] = 14, -- J Shape
	[10] = 14, -- L Shape
	[11] = 14, -- Reverse r Shape
	[12] = 14, -- r Shape
}


local function hasLimitimer()
	local playerCount = Game():GetNumPlayers()
	for playerIndex = 0, playerCount - 1 do
		local player = Isaac.GetPlayer(playerIndex)
		if player:HasCollectible(limitimer_item) then return true end
	end
	return false
end


local function applyLevelTime()
	local level = Game():GetLevel()

	local levelTime = 0

	local rooms = level:GetRooms()
	for i = 1, rooms.Size - 1 do
		local room = rooms:Get(i)
		levelTime = levelTime + (30)*shapeTime[room.Data.Shape]
	end

	Game().TimeCounter = levelTime
end

local test = 0

function limitimer:OnFrame()
	if not hasLimitimer() then return end

	if Game().Difficulty > 1 then
		for playerIndex = 0, playerCount - 1 do
			local player = Isaac.GetPlayer(playerIndex)
			player:RemoveCollectible(limitimer_item)
		end
		return
	end

	local room = Game():GetRoom()

	print(Game().TimeCounter - test)

	if (room:GetType() == 11 or room:GetType() == 17)
	and not room:IsAmbushDone() then Game().TimeCounter = math.max(Game().TimeCounter - 1, 0)
	else Game().TimeCounter = math.max(Game().TimeCounter - 2, 0) end

	test = Game().TimeCounter

	if Game().TimeCounter == 0 then
		local playerCount = Game():GetNumPlayers()
		for playerIndex = 0, playerCount - 1 do
			local player = Isaac.GetPlayer(playerIndex)
			player:Die()
			if player:WillPlayerRevive() then Game().TimeCounter = 32*30 end
		end
	end

end LIMITIMER:AddCallback(ModCallbacks.MC_POST_UPDATE, limitimer.OnFrame)


function limitimer:OnNewFloor()
	local level = Game():GetLevel()

	if level:GetStage() == 1 and not level:IsAltStage() then Isaac.Spawn(5, 100, limitimer_item, Vector(12*40, 10*40), Vector(0, 0), nil) end

	if not hasLimitimer() then return end

	applyLevelTime()

end LIMITIMER:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, limitimer.OnNewFloor)


function limitimer:OnCompleteRoom()
	if not hasLimitimer() then return end
	local playerCount = Game():GetNumPlayers()
	for playerIndex = 0, playerCount - 1 do
		local player = Isaac.GetPlayer(playerIndex)
		player:AddCacheFlags(CacheFlag.CACHE_SPEED)
		player:EvaluateItems()
	end
end LIMITIMER:AddCallback(ModCallbacks.MC_PRE_SPAWN_CLEAN_AWARD, limitimer.OnCompleteRoom)


function limitimer:OnNewRoom()
	for _, entity in pairs(Isaac.GetRoomEntities()) do
		if entity.Type == 5 and entity.Variant == 100 and entity.SubType == limitimer_item then
			entity:Remove()
		end
	end
	local playerCount = Game():GetNumPlayers()
	for playerIndex = 0, playerCount - 1 do
		local player = Isaac.GetPlayer(playerIndex)
		player:AddCacheFlags(CacheFlag.CACHE_SPEED)
		player:EvaluateItems()
	end
end LIMITIMER:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, limitimer.OnNewRoom)


function limitimer:OnPeffect(player)
	if Game().Difficulty > 1 then return end
	if player.QueuedItem.Item
	and player.QueuedItem.Item.Type == ItemType.ITEM_PASSIVE
	and player.QueuedItem.Item.ID == limitimer_item then
		applyLevelTime()
	end
end LIMITIMER:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, limitimer.OnPeffect)


function limitimer:OnCache(player, cacheFlag)
	if not hasLimitimer() then return end

	local room = Game():GetRoom()
	if cacheFlag == CacheFlag.CACHE_SPEED and (room:IsAmbushDone() or room:IsClear()) then
		player.MoveSpeed = 2
	end
	if cacheFlag == CacheFlag.CACHE_FIREDELAY then player.MaxFireDelay = player.MaxFireDelay/1.6 end
	if cacheFlag == CacheFlag.CACHE_DAMAGE then player.Damage = player.Damage*1.2 end

end LIMITIMER:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, limitimer.OnCache)


if EID then
	EID:setModIndicatorName("The Limitimer")
	EID:setModIndicatorIcon("Collectible"..limitimer_item.."")

	EID:addCollectible(limitimer_item,
	"↑  {{Speed}} 2 Speed on clear rooms"..
	"#↑  {{Tears}} 1.6 Tears multiplier"..
	"#↑  {{Damage}} 1.2 Damage multiplier"..
	"#{{Warning}} The timer decrements, if it reaches 0 all players die"..
	"#The amount of rooms in a floor increases it's limit time"
	)
end
