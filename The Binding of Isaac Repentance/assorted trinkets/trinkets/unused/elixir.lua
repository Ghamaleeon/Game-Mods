local elixir = {}

local ELIXIR = Isaac.GetTrinketIdByName("Elixir")

local function BreakElixir(player)
	for _=1, player:GetTrinketMultiplier(ELIXIR) do player:AddCollectible(448) end
	player:AddHearts(-player:GetHearts())
	player:AddHearts(player:GetEffectiveMaxHearts())
	if player:GetTrinketMultiplier(ELIXIR) > 1 then player:AddGoldenHearts(player:GetEffectiveMaxHearts()) end
	player:TryRemoveTrinket(ELIXIR)
	player:TakeDamage(1, DamageFlag.DAMAGE_FAKE, EntityRef(player), 60)

	SFXManager():Play(SoundEffect.SOUND_GLASS_BREAK)
	SFXManager():Play(SoundEffect.SOUND_VAMP_GULP)
end

function elixir:OnPlayerDamaged(player, amount, _, _, _)
	player = player:ToPlayer()
	if not player:HasTrinket(ELIXIR) or (player:GetHearts() + player:GetBoneHearts()) - amount > 0 then return end
	BreakElixir(player)
	return false
end ASSORTEDTRINKETS:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, elixir.OnPlayerDamaged, EntityType.ENTITY_PLAYER)

function elixir:OnSmelter(_, _, player, _, _)
	if not player:HasTrinket(ELIXIR) then return end
	if player:GetPlayerType() == gammaType then return end
	BreakElixir(player)
end ASSORTEDTRINKETS:AddCallback(ModCallbacks.MC_USE_ITEM, elixir.OnSmelter, CollectibleType.COLLECTIBLE_SMELTER)

function elixir:OnGulp(_, player, _)
	if not player:HasTrinket(ELIXIR) then return end
	if player:GetPlayerType() == gammaType then return end
	BreakElixir(player)
end ASSORTEDTRINKETS:AddCallback(ModCallbacks.MC_USE_PILL, elixir.OnGulp, PillEffect.PILLEFFECT_GULP)

if EID then
	EID:setModIndicatorName("Elixir")
	EID:setModIndicatorIcon("Trinket"..ELIXIR.."")

	EID:addTrinket(ELIXIR,
	"Upon fatal damage or gulping this trinket:"..
	"#{{Collectible448}} Gives Shard of Glass"..
	"#{{Collectible486}} Does fake damage"..
	"#{{Heart}} Full heals"..
	"#Destroys itself"
	)
	EID:addGoldenTrinketMetadata(ELIXIR,
		"{{TreasureRoom}} Gives a golden heart for each heart container"
	)
end