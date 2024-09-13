local adept = {}

function adept:OnNewFloor()
	local playerCount = Game():GetNumPlayers()
	
	for playerIndex = 0, playerCount - 1 do
        local player = Isaac.GetPlayer(playerIndex)
		local currentCurse = Game():GetLevel():GetCurseName()
		
		if false then return end --Colocar o id do item no lugar do false
		
		if currentCurse == "Curse of Darkness!" then
			player:UseCard(Card.CARD_SOUL_BETHANY, UseFlag.USE_NOANIM|UseFlag.USE_NOANNOUNCER)
		end
		
		if currentCurse == "Curse of the Lost!" then
			player:UseCard(Card.CARD_HOLY, UseFlag.USE_NOANIM|UseFlag.USE_NOANNOUNCER)
		end
		
		if currentCurse == "Curse of the Maze!" then
			player:UseCard(Card.CARD_SOUL_APOLLYON, UseFlag.USE_NOANIM|UseFlag.USE_NOANNOUNCER)
		end
		
		if currentCurse == "Curse of the Blind!" then
			player:UseActiveItem(CollectibleType.COLLECTIBLE_LEMEGETON, false)
		end
		
		if currentCurse == "Curse of the Unknown!" then
			local decision = Random() % 4
			if decision == 0 then player:AddBlackHearts(2)
			elseif decision == 1 then player:AddBoneHearts(1)
			elseif decision == 2 then player:AddMaxHearts(2)
			elseif decision == 3 then player:AddSoulHearts(2)
			end
		end
		
		if currentCurse == "Curse of the Labyrinth!" then
			for _ in 5 do player:AddMinisaac(player.position) end
		end
	end
end

adept:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, adept.OnNewFloor)