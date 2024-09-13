local polypolar = {}

local P = PlayerType

local CHARACTERLIST = {
	[P.PLAYER_BLUEBABY] = "SOUL",
	[P.PLAYER_LAZARUS] = false,
	[P.PLAYER_THELOST] = "NONE",
	[P.PLAYER_BLACKJUDAS] = "BLACK",
	[P.PLAYER_KEEPER] = "COIN",
	[P.PLAYER_THEFORGOTTEN] = "BONE",
	[P.PLAYER_THESOUL] = false,
	[P.PLAYER_BETHANY] = "RED",
	[P.PLAYER_ESAU] = false,
	[P.PLAYER_JUDAS_B] = "BLACK",
	[P.PLAYER_BLUEBABY_B] = "SOUL",
	[P.PLAYER_THELOST_B] = "NONE",
	[P.PLAYER_KEEPER_B] = "COIN",
	[P.PLAYER_THEFORGOTTEN_B] = "SOUL",
	[P.PLAYER_BETHANY_B] = "SOUL",
	[P.PLAYER_LAZARUS2_B] = false,
	[P.PLAYER_JACOB2_B] = "NONE",
	[P.PLAYER_THESOUL_B] = false,
}

local function changePlayer(player)
	local data = player:GetData()

	if data.polypolarHealth == nil then
		data.polypolarHealth = {
			["container"] = player:GetMaxHearts(),
			["containerBone"] = player:GetBoneHearts(),
			["redValue"] = math.max(player:GetHearts() - player:GetRottenHearts(), 0),
			["soulValue"] = player:GetSoulHearts(),
			["rottenValue"] = player:GetRottenHearts(),
			["eternalValue"] = player:GetEternalHearts(),
			["goldenValue"] = player:GetGoldenHearts(),
		}
	end


	if CHARACTERLIST[player:GetPlayerType()] == "SOUL" or CHARACTERLIST[player:GetPlayerType()] == "BLACK" then
		data.polypolarHealth["soulValue"] = player:GetSoulHearts() - data.polypolarHealth["container"]
		data.polypolarHealth["eternalValue"] = player:GetEternalHearts()
		data.polypolarHealth["goldenValue"] = player:GetGoldenHearts()
	elseif not CHARACTERLIST[player:GetPlayerType()] == "NONE" then
		data.polypolarHealth["container"] = player:GetMaxHearts()
		data.polypolarHealth["containerBone"] = player:GetBoneHearts()
		data.polypolarHealth["redValue"] = math.max(player:GetHearts() - player:GetRottenHearts(), 0)
		data.polypolarHealth["soulValue"] = player:GetSoulHearts()
		data.polypolarHealth["rottenValue"] = player:GetRottenHearts()
		data.polypolarHealth["eternalValue"] = player:GetEternalHearts()
		data.polypolarHealth["goldenValue"] = player:GetGoldenHearts()
	end

	local choice = 40
	while CHARACTERLIST[choice] == false do
		choice = (Random() % 20) + (player:GetPlayerType() <= 20 and 0 or 21)
	end

	local oldType = player:GetPlayerType()
	player:ChangePlayerType(choice)
	SFXManager():Play(SoundEffect.SOUND_LAZARUS_FLIP_DEAD)

	if CHARACTERLIST[player:GetPlayerType()] == CHARACTERLIST[oldType] then return end

	player:AddMaxHearts(-36)
	player:AddBoneHearts(-36)
	player:AddSoulHearts(-36)
	player:AddEternalHearts(-36)
	player:AddGoldenHearts(-36)

	if CHARACTERLIST[player:GetPlayerType()] == "SOUL" then
		player:AddBoneHearts(data.polypolarHealth["containerBone"])
		player:AddSoulHearts(data.polypolarHealth["soulValue"] + data.polypolarHealth["container"])
		player:AddEternalHearts(data.polypolarHealth["eternalValue"])
		player:AddGoldenHearts(data.polypolarHealth["goldenValue"])
	elseif CHARACTERLIST[player:GetPlayerType()] == "BLACK" then
		player:AddBlackHearts(data.polypolarHealth["soulValue"] + data.polypolarHealth["container"])
		player:AddBoneHearts(data.polypolarHealth["containerBone"])
		player:AddEternalHearts(data.polypolarHealth["eternalValue"])
		player:AddGoldenHearts(data.polypolarHealth["goldenValue"])
	else
		player:AddMaxHearts(data.polypolarHealth["container"])
		player:AddBoneHearts(data.polypolarHealth["containerBone"])
		player:AddHearts(data.polypolarHealth["redValue"])
		player:AddSoulHearts(data.polypolarHealth["soulValue"])
		player:AddEternalHearts(data.polypolarHealth["eternalValue"])
		player:AddGoldenHearts(data.polypolarHealth["goldenValue"])
	end

end

function polypolar:OnRoomClear(_, _)
	local playerCount = Game():GetNumPlayers()

	for playerIndex = 0, playerCount - 1 do
		local player = Isaac.GetPlayer(playerIndex)
		if player:GetPlayerType() == -1 then return end

		changePlayer(player)

	end
end

GammaMod:AddCallback(ModCallbacks.MC_PRE_SPAWN_CLEAN_AWARD, polypolar.OnRoomClear)
