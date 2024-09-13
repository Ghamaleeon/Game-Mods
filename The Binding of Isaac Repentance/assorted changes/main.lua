if not REPENTOGON then return end

-- AssortedChanges = RegisterMod("assorted changes", 1)
-- local mod = AssortedChanges

-- local C = CollectibleType
-- local CUSTOMCOSTUME = {
-- 	[C.COLLECTIBLE_SACRED_HEART] = C.COLLECTIBLE_HEART,
-- 	[C.COLLECTIBLE_PYROMANIAC] = C.COLLECTIBLE_HOST_HAT,
-- 	[C.COLLECTIBLE_HOST_HAT] = true,
-- 	[C.COLLECTIBLE_MONSTROS_LUNG] = true,
-- 	[C.COLLECTIBLE_PJS] = true,
-- 	[C.COLLECTIBLE_CEREMONIAL_ROBES] = true,
-- 	["Quality"] = {[4] = true},
-- 	["Flight"] = true,
-- 	[C.COLLECTIBLE_DOGMA] = true,
-- }


-- local function customCostume(itemConfig, player)
-- 	local group = CUSTOMCOSTUME["Quality"][itemConfig.Quality] or (CUSTOMCOSTUME["Flight"] and itemConfig.Costume.IsFlying)
-- 	if (group or CUSTOMCOSTUME[itemConfig.ID] == true)
-- 	and not (CUSTOMCOSTUME[itemConfig.ID] == false
-- 	or (type(CUSTOMCOSTUME[itemConfig.ID]) == "number" and CUSTOMCOSTUME[itemConfig.ID]) ~= true) then return end
-- 	player:RemoveCostume(itemConfig)
-- 	if type(CUSTOMCOSTUME[itemConfig.ID]) == "number" then
-- 		player:AddCostume(Isaac.GetItemConfig():GetCollectible(CUSTOMCOSTUME[itemConfig.ID]))
-- 	end
-- end


-- function mod:OnAddCollectible(collectible, _, _, _, _, player)
-- 	customCostume(Isaac.GetItemConfig():GetCollectible(collectible), player)
-- end
-- mod:AddCallback(ModCallbacks.MC_POST_ADD_COLLECTIBLE, mod.OnAddCollectible)


-- function mod:OnRemoveCollectible(player, collectible)
-- 	if type(CUSTOMCOSTUME[collectible]) ~= "number" then return end
-- 	customCostume(Isaac.GetItemConfig():GetCollectible(CUSTOMCOSTUME[collectible]), player)
-- end
-- mod:AddCallback(ModCallbacks.MC_POST_TRIGGER_COLLECTIBLE_REMOVED, mod.OnRemoveCollectible)


-- function mod:OnAddTrinket(player, trinket, _)
-- 	customCostume(Isaac.GetItemConfig():GetTrinket(trinket), player)
-- end
-- mod:AddCallback(ModCallbacks.MC_POST_TRIGGER_TRINKET_ADDED, mod.OnAddTrinket)


----------------------------------------------


local P = PlayerType
local T = TrinketType
local STARTTRINKET = {
	[P.PLAYER_ISAAC] = T.TRINKET_GOLDEN_HORSE_SHOE,
	[P.PLAYER_MAGDALENE] = T.TRINKET_CROW_HEART,
	[P.PLAYER_CAIN] = T.TRINKET_PAPER_CLIP,
	[P.PLAYER_JUDAS] = T.TRINKET_YOUR_SOUL,
	[P.PLAYER_BLUEBABY] = T.TRINKET_MECONIUM,
	[P.PLAYER_EVE] = T.TRINKET_EVES_BIRD_FOOT,
	[P.PLAYER_SAMSON] = T.TRINKET_CHILDS_HEART,
	[P.PLAYER_AZAZEL] = T.TRINKET_DAEMONS_TAIL,
	[P.PLAYER_LAZARUS] = T.TRINKET_LOST_CORK,
	[P.PLAYER_THELOST] = T.TRINKET_FRAGMENTED_CARD,
	[P.PLAYER_LILITH] = T.TRINKET_CHILD_LEASH,
	[P.PLAYER_KEEPER] = T.TRINKET_STORE_KEY,
	[P.PLAYER_APOLLYON] = T.TRINKET_CALLUS,
	[P.PLAYER_THEFORGOTTEN] = T.TRINKET_FINGER_BONE,
	[P.PLAYER_BETHANY] = T.TRINKET_BETHS_ESSENCE,
	[P.PLAYER_JACOB] = T.TRINKET_BROKEN_GLASSES,
	[P.PLAYER_ESAU] = T.TRINKET_BROKEN_GLASSES,
	[P.PLAYER_ISAAC_B] = T.TRINKET_DICE_BAG,
	[P.PLAYER_MAGDALENE_B] = T.TRINKET_MOTHERS_KISS,
	[P.PLAYER_CAIN_B] = T.TRINKET_CRYSTAL_KEY,
	[P.PLAYER_JUDAS_B] = T.TRINKET_LEFT_HAND,
	[P.PLAYER_BLUEBABY_B] = T.TRINKET_GIGANTE_BEAN,
	[P.PLAYER_EVE_B] = T.TRINKET_STEM_CELL,
	[P.PLAYER_SAMSON_B] = T.TRINKET_SWALLOWED_M80,
	[P.PLAYER_AZAZEL_B] = T.TRINKET_NUMBER_MAGNET,
	[P.PLAYER_LAZARUS_B] = T.TRINKET_CANCER,
	[P.PLAYER_LAZARUS2_B] = T.TRINKET_FISH_HEAD,
	[P.PLAYER_THELOST_B] = T.TRINKET_CRACKED_CROWN,
	[P.PLAYER_LILITH_B] = T.TRINKET_FRIENDSHIP_NECKLACE,
	[P.PLAYER_KEEPER_B] = T.TRINKET_SILVER_DOLLAR,
	[P.PLAYER_APOLLYON_B] = T.TRINKET_BAT_WING,
	[P.PLAYER_THEFORGOTTEN_B] = T.TRINKET_HOLLOW_HEART,
	[P.PLAYER_BETHANY_B] = T.TRINKET_BLACK_LIPSTICK,
	[P.PLAYER_JACOB_B] = T.TRINKET_WOODEN_CROSS,
}


function mod:OnPlayerInit(player)
	local playerType = player:GetPlayerType()
	if not STARTTRINKET[playerType] then return end
	local itemPool = Game():GetItemPool()

	player:AddTrinket(STARTTRINKET[playerType])
	itemPool:RemoveTrinket(STARTTRINKET[playerType])
end
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, mod.OnPlayerInit)