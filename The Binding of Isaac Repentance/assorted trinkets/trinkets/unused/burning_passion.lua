local burningPassion = {}

local BURNINGPASSION = Isaac.GetTrinketIdByName("Burning Passion")

function burningPassion:OnHeartCollision(heart, player, _)
	if player.Type ~= EntityType.ENTITY_PLAYER then return end
	player = player:ToPlayer()
	if player:GetTrinketRNG(BURNINGPASSION):RandomFloat() > 0.5 * player:GetTrinketMultiplier(BURNINGPASSION) then return end
	for _=1, player:GetTrinketMultiplier(BURNINGPASSION) do
		local wisp = nil
		if heart.SubType == HeartSubType.HEART_ETERNAL then wisp = player:AddWisp(CollectibleType.COLLECTIBLE_PRAYER_CARD, heart.Position, true)
		elseif heart.SubType == HeartSubType.HEART_GOLDEN then
			for _=1, 8 do
				wisp = player:AddWisp(CollectibleType.COLLECTIBLE_WOODEN_NICKEL, heart.Position, true)
			end
		elseif heart.SubType == HeartSubType.HEART_ROTTEN then wisp = player:AddWisp(CollectibleType.COLLECTIBLE_YUCK_HEART, heart.Position, true)
		else
			wisp = player:AddWisp(CollectibleType.COLLECTIBLE_ABYSS, heart.Position, true)
			wisp.HitPoints = 2
		end
	end
	heart:Remove()

	return true
end GammaMod:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, burningPassion.OnHeartCollision, PickupVariant.PICKUP_HEART)

if EID then
	EID:setModIndicatorName("Burning Passion")
	EID:setModIndicatorIcon("Trinket"..BURNINGPASSION.."")

	EID:addTrinket(BURNINGPASSION,
	"{{Collectible706}} 50% of any touched hearts get converted into Abyss wisps"..
	"#{{EternalHeart}}{{GoldenHeart}}{{RottenHeart}} have special wisps"..
	"#{{Warning}} Effect might consume hearts needed for healing"
	)
	EID:addGoldenTrinketMetadata(BURNINGPASSION,
	"{{TreasureRoom}} Always converts, double wisp amount"
	)
end