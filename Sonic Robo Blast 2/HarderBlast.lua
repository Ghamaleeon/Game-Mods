addHook("MobjDamage", function(target, inflictor, source, damage, damagetype)
	if target and target.player and target.player.rings > 0
	and not target.player.powers[pw_shield] and damage > 0 then
		P_DamageMobj(target, nil, nil, 0, DMG_INSTAKILL)
	end
end)

addHook("PlayerThink", function(player)
	player.lives = min($,1)
	player.continues = 0
	if player.powers[pw_super] and leveltime % 35 == 18 then P_GivePlayerRings(player, -1) end
end)

addHook("MobjSpawn", function(object)
	--P_RandomRange(0, 100) <= 50
	if object.type == MT_RING_BOX then object.type = MT_EGGMAN_BOX
	elseif object.type == MT_1UP_BOX then object.type = MT_SCORE10K_BOX
	elseif object.type == MT_ELEMENTAL_BOX then object.type = MT_FLAMEAURA_BOX
	end
	
	if object.type == MT_BLUECRAWLA then object.type = MT_REDCRAWLA
	elseif object.type == MT_SPRINGSHELL then object.type = MT_YELLOWSHELL
	elseif object.type == MT_GOLDBUZZ then object.type = MT_REDBUZZ
	elseif object.type == MT_EGGGUARD then object.type = MT_SPINCUSHION
	elseif object.type == MT_CANARIVORE then object.type = MT_POPUPTURRET
	elseif object.type == MT_UNIDUS then object.type = MT_DETON
	end
	
end)