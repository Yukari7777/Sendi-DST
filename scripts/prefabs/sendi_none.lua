local assets =
{
	Asset( "ANIM", "anim/sendi.zip" ),
	Asset( "ANIM", "anim/ghost_sendi_build.zip" ),
}

local skins =
{
	normal_skin = "sendi",
	ghost_skin = "ghost_sendi_build",
}

return CreatePrefabSkin("sendi_none",
{
	base_prefab = "sendi",
	type = "base",
	assets = assets,
	skins = skins, 
	skin_tags = {"SENDI", "CHARACTER", "BASE"},
	build_name = "sendi",
	rarity = "Common",
})