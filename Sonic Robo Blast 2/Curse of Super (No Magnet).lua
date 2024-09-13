addHook("PlayerThink", function(player)
	if player.mo.starttrigger or player.bot then return end
	player.mo.starttrigger = true
	if not (player.charflags & SF_SUPER) then player.charflags = $1|SF_SUPER end
	if not emeralds then emeralds = $|EMERALD1|EMERALD2|EMERALD3|EMERALD4|EMERALD5|EMERALD6|EMERALD7 end
	if player.solchar then player.solchar.istransformed = 1
	else player.powers[pw_super] = 1 end
	P_GivePlayerRings(player, 23)
	player.mo.state = S_PLAY_STND
end)

addHook("PlayerThink", function(player)
	if player.bot then return end
	if player.rings <= 0 then P_DamageMobj(player.mo, nil, nil, 0, DMG_INSTAKILL) end
	
	if player.powers[pw_extralife] then player.mo.got1up = true
	else
		if player.mo.got1up == true then
			S_SetMusicPosition(player.mo.storedmusicpos)
			S_SetInternalMusicVolume(0, player)
			S_FadeMusic(100, MUSICRATE, player)
			player.mo.got1up = false
		end
		player.mo.storedmusicpos = S_GetMusicPosition()
	end
	
	if player.powers[pw_invulnerability] > 3 * TICRATE and not player.sparkles then player.sparkles = true end
	if player.powers[pw_invulnerability] <= 1 and player.sparkles then player.sparkles = false end
	if player.powers[pw_sneakers] > 1 then
		player.powers[pw_sneakers] = 1
		S_StartSound(mo, sfx_itemup)
		P_GivePlayerRings(player, 10)
	end
	
	if (player.sparkles and player.powers[pw_super]) or stoppedclock or player.pflags & PF_FINISHED then
		if not player.mo.storedrings or player.rings > player.mo.storedrings then player.mo.storedrings = player.rings end
		if player.rings < player.mo.storedrings then player.rings = player.mo.storedrings end
	else player.mo.storedrings = 0 end
end)

addHook("TouchSpecial", function(emeraldtoken, mo)
	if not emeraldtoken.grabbed then return end
	P_GivePlayerRings(mo.player, 25)
	P_AddPlayerScore(mo.player, 1000)
	S_StartSound(mo, sfx_chchng)
	emeraldtoken.grabbed = true
	P_KillMobj(emeraldtoken)
	return true
end, MT_TOKEN)

addHook("MobjDamage", function(target, inflictor, source, damage, damagetype)
	if source and source.player and source.player.sparkles
	and (target.flags & MF_ENEMY) then
		P_GivePlayerRings(source.player, 2)
		S_StartSound(source, sfx_itemup)
	end
	if (target.flags & MF_BOSS) then
		for player in players.iterate
			if player.bot then return end
			if target.type == MT_METALSONIC_BATTLE then P_GivePlayerRings(player, 2) end
			P_GivePlayerRings(player, 5)
			S_StartSound(source, sfx_kc5e)
		end
	end
end)
