local assets =
{
	Asset( "ANIM", "anim/ghamaleeon.zip" ),
	Asset( "ANIM", "anim/ghost_ghamaleeon_build.zip" ),
}

local skins =
{
	normal_skin = "ghamaleeon",
	ghost_skin = "ghost_ghamaleeon_build",
}

return CreatePrefabSkin("ghamaleeon_none",
{
	base_prefab = "ghamaleeon",
	type = "base",
	assets = assets,
	skins = skins, 
	skin_tags = {"GHAMALEEON", "CHARACTER", "BASE"},
	build_name_override = "ghamaleeon",
	rarity = "Character",
})