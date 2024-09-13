if not REPENTANCE then return end

ANYTHINGPILL = RegisterMod("Anything Pill", 1)
local mod = ANYTHINGPILL

local anythingPill = Isaac.GetPillEffectByName("Anything is Possible!")

function mod:UsePill(pillEffect, player, useFlags)
	if pillEffect == anythingPill then
		player:UseActiveItem(CollectibleType.COLLECTIBLE_METRONOME, useFlags)
		SFXManager():Play(player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_METRONOME):RandomInt(SoundEffect.NUM_SOUND_EFFECTS))
	end
end mod:AddCallback(ModCallbacks.MC_USE_PILL, mod.UsePill)
