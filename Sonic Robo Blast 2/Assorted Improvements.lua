-- Flame Trail
local function FlameTrail(player)
	if (leveltime % 2 == 0)
	and (P_IsObjectOnGround(player.mo)) then P_ElementalFire(player, false) end
end
-- Super Impact
local function SuperImpact(player)
	if not player.powers[pw_super] then return end
	if (P_IsObjectOnGround(player.mo)) or (player.mo.eflags & MFE_JUSTHITFLOOR) then P_NukeEnemies(player.mo, player.mo, FRACUNIT*1536/3)
	else P_Earthquake(player.mo, player.mo, FRACUNIT*1536/3) end
	S_StartSound(player.mo, sfx_s3k49)
	P_StartQuake(20 * FRACUNIT, 4)
end
-- On Spawn
addHook("PlayerThink", function(player)
	if player.mo.starttrigger or player.bot then return end
	player.mo.starttrigger = true
	player.lives = max($, 3)
	hud.disable('lives')
	player.isinboss = (player.rings > 9)
	if player.isinboss then
		if player.score >= 11000 then P_AddPlayerScore(player, -11000)
		else P_AddPlayerScore(player, -player.score) end
		player.pflags = $|PF_FINISHED
	end
	player.spinitem = MT_NULL
end)
-- Spin Control
addHook("PlayerThink", function(player)
	if player.charability2 ~= CA2_SPINDASH then return end
	if (player.pflags & PF_SPINNING)
	and not (player.pflags & PF_STARTDASH)
	and ((player.cmd.forwardmove ~= 0) or (player.cmd.sidemove ~= 0))
	and (P_IsObjectOnGround(player.mo))
	and (player.speed > FRACUNIT) then
		local motion = R_PointToAngle2(0, 0, player.mo.momx, player.mo.momy)
		local pangle = player.mo.angle + R_PointToAngle2(0, 0, player.cmd.forwardmove*FRACUNIT, -player.cmd.sidemove*FRACUNIT)
		local turn = 0 
		local turning = FixedAngle(FixedMul(FixedDiv(AngleFixed(ANG2), 13*FRACUNIT/32, player.speed), player.mo.friction))
		local dif = pangle - motion
		if dif > turning or dif < -turning then
			if dif > 0 then turn = motion + turning
			else turn = motion - turning end
		else turn = pangle end
		P_InstaThrust(player.mo, turn, FixedHypot(player.mo.momx, player.mo.momy))
	end
end)
-- No Fall Walking, Roll Midair
addHook("PlayerThink", function(player)
	if not (P_IsObjectOnGround(player.mo))
	and ((player.mo.state == S_PLAY_WALK)
	or (player.mo.state == S_PLAY_RUN)
	or (player.mo.state == S_PLAY_SPRING))
	and not player.powers[pw_carry] then
		if player.charability2 == CA2_SPINDASH then player.pflags = $|PF_JUMPED
		else player.pflags = $|PF_JUMPED|PF_NOJUMPDAMAGE end
		player.pflags = player.pflags & ~PF_THOKKED
		player.mo.state = S_PLAY_JUMP
	end
	if not (P_IsObjectOnGround(player.mo))
	and (player.pflags & PF_SPINNING)
	and (player.charge or not (player.cmd.buttons & BT_SPIN)) then
		player.pflags = player.pflags & ~PF_SPINNING
		player.pflags = $|PF_JUMPED
	end
end)
-- Dashmode 0.5
addHook("PlayerThink", function(player)
	if (player.charflags & SF_DASHMODE) then return end
	if player.speed >= player.normalspeed-5*FRACUNIT then player.normalspeed = min(skins[player.mo.skin].normalspeed*5/3, player.normalspeed + FRACUNIT/13)
	elseif player.speed < player.runspeed then player.normalspeed = max(skins[player.mo.skin].normalspeed, player.normalspeed - FRACUNIT) end
end)
-- Pizza Tower Afterimages
addHook("PlayerThink", function(player)
	if (player.speed >= player.runspeed
	or ((player.pflags & PF_SPINNING) and player.speed > 0))
	and not player.powers[pw_super] then
		if (leveltime % 4 == 0) then
			local ghost = P_SpawnGhostMobj(player.mo)
			if P_RandomChance(FRACUNIT/2) then ghost.color = SKINCOLOR_RED
			else ghost.color = SKINCOLOR_GREEN end
			ghost.colorized = true
			ghost.frame = FF_FULLBRIGHT|player.mo.frame|TR_TRANS10
		end
	end
end)
-- Drop Dash
addHook("SpinSpecial", function(player)
	if player.charability2 == CA2_SPINDASH
	and not (player.pflags & PF_THOKKED)
	and ((player.powers[pw_shield] == 0
	or player.powers[pw_shield] == 1
	or player.powers[pw_shield] == 4
	or player.powers[pw_shield] == 512
	or player.powers[pw_shield] == 513
	or player.powers[pw_shield] == 516)
	or player.powers[pw_super])
	and not (player.powers[pw_super] and player.mo.skin == "sonic")
	and not (player.pflags & PF_FULLSTASIS)
	and not (player.pflags & PF_FINISHED)
	and (player.pflags & PF_JUMPED)
	and ((player.mo.state == S_PLAY_JUMP) or (player.mo.state == S_PLAY_ROLL))
	and (P_IsObjectOnGround(player.mo) == false)
	and not player.charge then
		S_StartSound(player.mo, sfx_spndsh) 
		player.mo.state = S_PLAY_SPINDASH
		player.charge = 1
	end
end)
addHook("PlayerThink", function(player)
	if player.charability2 ~= CA2_SPINDASH then return end
	if player.charge
	and (player.cmd.buttons & BT_SPIN)
	and not (player.pflags & PF_FINISHED) then
		player.charge = min(max($1 + FRACUNIT, max(player.mindash, player.speed)), player.maxdash)
		player.dashspeed = player.charge
	elseif player.charge then
		player.charge = 0
		player.mo.state = S_PLAY_JUMP
	end
	if player.charge
	and ((P_IsObjectOnGround(player.mo)) or (player.mo.eflags & MFE_JUSTHITFLOOR)) then
		S_StartSound(player.mo, sfx_zoom)
		player.mo.state = S_PLAY_ROLL
		player.charge = 0
		player.pflags = $|PF_SPINNING
		P_InstaThrust(player.mo, player.mo.angle, player.dashspeed)
		SuperImpact(player)
	end
	if player.charge
	and ((player.mo.state ~= S_PLAY_SPINDASH) or (player.pflags & PF_THOKKED)) then
		if (player.mo.state == S_PLAY_SPINDASH) then player.mo.state = S_PLAY_JUMP end
		player.charge = 0
	end
end)
-- Improved Flight, Super Infinite Flight
addHook("PlayerThink", function(player)
	if player.charability ~= CA_FLY
	and player.charability ~= CA_SWIM then return end
	if (player.cmd.buttons & BT_JUMP) then player.fly1 = 1 end
	if player.powers[pw_super]
	and player.powers[pw_tailsfly]
	and not (P_IsObjectOnGround(player.mo)) then
		player.powers[pw_tailsfly] = 8*TICRATE
	end
	if player.powers[pw_super] then player.actionspd = skins[player.mo.skin].actionspd*5/3
	else player.actionspd = skins[player.mo.skin].actionspd end
end)
-- Glide Renewal
addHook("PlayerThink", function(player)
	if not player.charability == CA_GLIDEANDCLIMB then return end
	local gliding = player.pflags & PF_GLIDING
	local thokked = player.pflags & PF_THOKKED
	local exitglide = (player.glidelast == 1 and not (gliding) and thokked)
	local landglide = (player.glidelast == 2 and not (gliding|thokked))
	if exitglide or landglide then
		player.mo.momx = FixedMul(P_ReturnThrustX(nil, R_PointToAngle2(0, 0, player.rmomx, player.rmomy), FixedDiv(FixedHypot(player.rmomx, player.rmomy), player.mo.scale)),player.mo.scale)
		player.mo.momy = FixedMul(P_ReturnThrustY(nil, R_PointToAngle2(0, 0, player.rmomx, player.rmomy), FixedDiv(FixedHypot(player.rmomx, player.rmomy), player.mo.scale)),player.mo.scale)
	end
	if gliding then	player.glidelast = 1
	elseif exitglide then
		player.glidelast = 2
		player.pflags = $|PF_JUMPED|PF_NOJUMPDAMAGE
		player.pflags = player.pflags & ~PF_THOKKED
	elseif not(gliding|thokked) then player.glidelast = 0 end
end)
-- TwinSpin WallJump, TwinSpin InstaShield, Faster Melee
addHook("MobjMoveBlocked", function(mo)
    if mo.player.charability ~= CA_TWINSPIN then return end
	local player = mo.player
	if (player.mo.state == S_PLAY_TWINSPIN) then
		if (player.mo.eflags & MFE_UNDERWATER) then player.mo.momz = P_MobjFlip(player.mo)*((10*FRACUNIT+player.speed/4)*2/3)
		else player.mo.momz = P_MobjFlip(player.mo)*(10*FRACUNIT+player.speed/4) end
		player.pflags = player.pflags & ~PF_NOJUMPDAMAGE
		player.mo.state = S_PLAY_ROLL
		S_StartSound(player.mo, sfx_sprong)
		SuperImpact(player)
	end
end, MT_PLAYER)
addHook("PlayerThink", function(player)
	if player.charability ~= CA_TWINSPIN then return end
	if (player.mo.state == S_PLAY_TWINSPIN) then player.powers[pw_flashing] = max($, 1) end
end)
addHook("PlayerThink", function(player)
	if player.charability2 ~= CA2_MELEE then return end
	if (player.mo.state == S_PLAY_MELEE_LANDING) then
		player.mo.state = S_PLAY_RUN
		SuperImpact(player)
	end
end)
-- Bounce Renewal
addHook("PlayerThink", function(player)
	if player.charability ~= CA_BOUNCE then return end
	if player.bouncelast == nil then player.bouncelast = false end
	if player.pflags&PF_BOUNCING and not(player.bouncelast)
	or (not(player.pflags&PF_BOUNCING) and player.pflags&PF_THOKKED and player.bouncelast)
		player.mo.momx = FixedMul(P_ReturnThrustX(nil, R_PointToAngle2(0, 0, player.rmomx, player.rmomy), FixedDiv(FixedHypot(player.rmomx, player.rmomy), player.mo.scale)),player.mo.scale)
		player.mo.momy = FixedMul(P_ReturnThrustY(nil, R_PointToAngle2(0, 0, player.rmomx, player.rmomy), FixedDiv(FixedHypot(player.rmomx, player.rmomy), player.mo.scale)),player.mo.scale)
		player.mo.momz = $*2
	end
	if (not(player.pflags&PF_BOUNCING) and player.pflags&PF_THOKKED and player.bouncelast) then
		player.pflags = $|PF_JUMPED|PF_NOJUMPDAMAGE
		player.pflags = player.pflags & ~PF_THOKKED
	end
	if (player.mo.state == S_PLAY_BOUNCE_LANDING) then
		player.mo.state = S_PLAY_BOUNCE
		player.mo.momz = $+(P_MobjFlip(player.mo)*(player.speed/(13/2)))
		SuperImpact(player)
	end
	player.bouncelast = (player.pflags&PF_BOUNCING > 0)
end)
-- Dashmode Fire
addHook("PlayerThink", function(player)
	if not (player.charflags & SF_DASHMODE) then return end
	if player.dashmode >= 108 then
		if not player.dashmodet then
			player.dashmodet = true
			if (P_IsObjectOnGround(player.mo)) then P_ElementalFire(player, true) end
		end
		player.powers[pw_flashing] = max($, 1)
		if not (player.mo.state == S_PLAY_SPINDASH) then FlameTrail(player) end
	elseif player.dashmodet then
		player.dashmodet = false
		if (P_IsObjectOnGround(player.mo)) then P_ElementalFire(player, true) end
	end
end)
-- No Nights plz
addHook("TouchSpecial", function(emeraldtoken, mo)
	if emeraldtoken.grabbed then return end
	if All7Emeralds(emeralds) then
		P_GivePlayerRings(mo.player, 50)
		P_AddPlayerScore(mo.player, 1000)
		S_StartSound(mo, sfx_chchng)
		emeraldtoken.grabbed = true
		P_KillMobj(emeraldtoken)
		return true
	else
		emeralds = 127
		S_StartSound(mo, sfx_ncitem)
		emeraldtoken.grabbed = true
		P_KillMobj(emeraldtoken)
		return true
	end
end, MT_TOKEN)
-- Button 3 Super
addHook("PlayerThink", function(player)
	if (player.charflags & SF_SUPER)
	and not (player.mo.state >= S_PLAY_SUPER_TRANS1 and player.mo.state <= S_PLAY_SUPER_TRANS6)
	and not (player.powers[pw_super]) then
		player.charflags = $ & ~SF_SUPER
	end
	if (player.cmd.buttons == BT_CUSTOM3)
	and All7Emeralds(emeralds)
	and ((player.rings >= 50) or (player.rings >= 10 and player.isinboss))
	and not (player.powers[pw_super])
	and not (player.mo.state >= S_PLAY_SUPER_TRANS1 and player.mo.state <= S_PLAY_SUPER_TRANS6)
	and not (player.solchar and player.solchar.istransformed)
	and not (player.pflags & PF_FINISHED) then
		player.charflags = $ | SF_SUPER
		S_StartSound(player.mo, sfx_bkpoof)
		P_NukeEnemies(player.mo, player.mo, FRACUNIT*1536)
		P_StartQuake(20 * FRACUNIT, 33)
		P_DoSuperTransformation(player, false)
	end
end)