local heartChip = {}

local HEARTCHIP = Isaac.GetTrinketIdByName("Heart Chip")


function heartChip:OnPlayerTakeDamage(player, amount, damageFlags, source, countdownFrames)
	player = player:ToPlayer()
	local data = ASSORTEDTRINKETS:Data(player)
	if not player:HasTrinket(HEARTCHIP) or data["HeartChip"] ~= nil then
		if data["HeartChip"] == true then data["HeartChip"] = nil end
		return
	end

	local totalHealth = player:GetHearts() + player:GetSoulHearts() + player:GetBoneHearts()
	if player:GetTrinketRNG(HEARTCHIP):RandomFloat() < (amount/totalHealth) / player:GetTrinketMultiplier(HEARTCHIP) then
		player:AddBrokenHearts(3*player:GetTrinketMultiplier(HEARTCHIP))
		if player:GetBrokenHearts() >= 12 then player:Die() end
	end

	data["HeartChip"] = true
	player:TakeDamage(amount, damageFlags|DamageFlag.DAMAGE_FAKE, source, countdownFrames)
	return false
end ASSORTEDTRINKETS:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, heartChip.OnPlayerTakeDamage, EntityType.ENTITY_PLAYER)

if EID then
	EID:setModIndicatorName("Heart Chip")
	EID:setModIndicatorIcon("Trinket"..HEARTCHIP.."")

	EID:addTrinket(HEARTCHIP,
	"{{Warning}} Received damage gets nullified, but has a damage/health chance to give 3 {{BrokenHeart}} broken hearts"..
	"#Taking 1/2 heart with 3 hearts is a 1/6 chance (As an example)"..
	"#Golden version "
	)
	EID:addGoldenTrinketMetadata(HEARTCHIP,
		"{{TreasureRoom}} Chance halfed, broken hearts doubled"
	)
end
