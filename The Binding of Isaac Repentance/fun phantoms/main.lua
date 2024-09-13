FUNPHANTOMS = RegisterMod("Fun Phantoms",1)
local funphantoms = {}


function funphantoms:OnPlayerDamaged(player, amount, damageFlags, source, countdownFrames)
	player = player:ToPlayer()
	if (player:GetPlayerType() ~= PlayerType.PLAYER_JACOB2_B
	and player:GetPlayerType() ~= PlayerType.PLAYER_THELOST
	and player:GetPlayerType() ~= PlayerType.PLAYER_THELOST_B
	and not player:GetEffects():HasNullEffect(NullItemID.ID_LOST_CURSE))
	or player:HasCollectible(694) then return end

	if player:GetData().funphantoms == nil then player:GetData().funphantoms = {} end

	local data = player:GetData().funphantoms
	if data.tookDamage ~= nil then
		data.tookDamage = nil
		return
	end

	if player:GetPlayerType() == PlayerType.PLAYER_THELOST
	or player:GetEffects():HasNullEffect(NullItemID.ID_LOST_CURSE) then player:AddBrokenHearts(6)
	else player:AddBrokenHearts(3) end
	if player:GetBrokenHearts() >= 12 then return end

	data.tookDamage = true
	player:TakeDamage(amount, damageFlags|DamageFlag.DAMAGE_NOKILL, source, countdownFrames)

	return false
end FUNPHANTOMS:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, funphantoms.OnPlayerDamaged, EntityType.ENTITY_PLAYER)
