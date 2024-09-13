PrefabFiles = {
	"ghamaleeon",
	"ghamaleeon_none",
}

Assets = {
    Asset( "IMAGE", "images/saveslot_portraits/ghamaleeon.tex" ),
    Asset( "ATLAS", "images/saveslot_portraits/ghamaleeon.xml" ),

    Asset( "IMAGE", "images/selectscreen_portraits/ghamaleeon.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/ghamaleeon.xml" ),
	
    Asset( "IMAGE", "images/selectscreen_portraits/ghamaleeon_silho.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/ghamaleeon_silho.xml" ),

    Asset( "IMAGE", "bigportraits/ghamaleeon.tex" ),
    Asset( "ATLAS", "bigportraits/ghamaleeon.xml" ),
	
	Asset( "IMAGE", "images/map_icons/ghamaleeon.tex" ),
	Asset( "ATLAS", "images/map_icons/ghamaleeon.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_ghamaleeon.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_ghamaleeon.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_ghost_ghamaleeon.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_ghost_ghamaleeon.xml" ),
	
	Asset( "IMAGE", "images/avatars/self_inspect_ghamaleeon.tex" ),
    Asset( "ATLAS", "images/avatars/self_inspect_ghamaleeon.xml" ),
	
	Asset( "IMAGE", "images/names_ghamaleeon.tex" ),
    Asset( "ATLAS", "images/names_ghamaleeon.xml" ),
	
	Asset( "IMAGE", "images/names_gold_ghamaleeon.tex" ),
    Asset( "ATLAS", "images/names_gold_ghamaleeon.xml" ),
	
	Asset("SOUNDPACKAGE", "sound/ghamaleeon.fev"),
	Asset("SOUND", "sound/ghamaleeon.fsb"),
	
}

RemapSoundEvent("dontstarve/characters/ghamaleeon", "ghamaleeon/ghamaleeon")
RemapSoundEvent("dontstarve/characters/ghamaleeon/talk_LP", "ghamaleeon/ghamaleeon/talk_LP")
RemapSoundEvent("dontstarve/characters/ghamaleeon/ghost_LP", "ghamaleeon/ghamaleeon/ghost_LP")
RemapSoundEvent("dontstarve/characters/ghamaleeon/hurt", "ghamaleeon/ghamaleeon/hurt")
RemapSoundEvent("dontstarve/characters/ghamaleeon/death_voice", "ghamaleeon/ghamaleeon/death_voice")
RemapSoundEvent("dontstarve/characters/ghamaleeon/emote", "ghamaleeon/ghamaleeon/emote")
RemapSoundEvent("dontstarve/characters/ghamaleeon/pose", "ghamaleeon/ghamaleeon/pose")
RemapSoundEvent("dontstarve/characters/ghamaleeon/yawn", "ghamaleeon/ghamaleeon/yawn")

AddMinimapAtlas("images/map_icons/ghamaleeon.xml")

local require = GLOBAL.require
local STRINGS = GLOBAL.STRINGS

STRINGS.CHARACTER_TITLES.ghamaleeon = "The Otherworldly Slime"
STRINGS.CHARACTER_NAMES.ghamaleeon = "Ghamaleeon"
STRINGS.CHARACTER_DESCRIPTIONS.ghamaleeon = "*Is a wet, frail slime\n*Has a diverse diet\n*And pickaxe fighting skills!"
STRINGS.CHARACTER_QUOTES.ghamaleeon = "\"No more souls, please...\""
STRINGS.CHARACTER_SURVIVABILITY.ghamaleeon = "Glimy..?"

STRINGS.CHARACTERS.GHAMALEEON = require "speech_webber"

STRINGS.NAMES.GHAMALEEON = "Ghamaleeon"
STRINGS.SKIN_NAMES.ghamaleeon_none = "Ghamaleeon"

local skin_modes = {
    { 
        type = "ghost_skin",
        anim_bank = "ghost",
        idle_anim = "idle", 
        scale = 1.00, 
        offset = { 0, -25 } 
    },
}
AddModCharacter("ghamaleeon", "MALE", skin_modes)

-- Hiding health meter, thanks to the Wilton the Skeleton mod developer for making this code!
local function noGhamaleeonMoistureHud(self, inst)
	if inst and inst.prefab == "ghamaleeon" then
		
		inst:ListenForEvent("ms_playerspawn", function()
			self.moisturemeter:Hide()
		end)
		
		inst:ListenForEvent("playeractivated", function()
			self.moisturemeter:Hide()
		end)
		
		inst:ListenForEvent("ms_respawnedfromghost", function()
			self.moisturemeter:Hide()
		end)
		
		inst:ListenForEvent("moisturedelta", function()
			self.moisturemeter:Hide()
		end)
	end
end
AddClassPostConstruct("widgets/statusdisplays", noGhamaleeonMoistureHud)
