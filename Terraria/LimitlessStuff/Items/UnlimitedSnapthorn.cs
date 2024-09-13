using Terraria;
using Terraria.ID;
using Terraria.ModLoader;
using Terraria.GameContent.Creative;

namespace LimitlessStuff.Items
{
	public class UnlimitedSnapthorn : ModItem
	{
		public override void SetStaticDefaults()
		{
			DisplayName.SetDefault("Snapthorn's Handle");
			Tooltip.SetDefault("Grants Jungle's Fury buff");
			CreativeItemSacrificesCatalog.Instance.SacrificeCountNeededByItemId[Type] = 1;
		}
		
		public override void SetDefaults()
		{
			Item.maxStack = 1;
			Item.rare = 1;
			Item.value = 0;
			Item.accessory = true;
		}
		
		public override void UpdateAccessory(Player player, bool hideVisual)
		{
			player.AddBuff(314, 1);
		}

		public override void AddRecipes()
		{
			Recipe recipe = CreateRecipe();
			recipe.AddIngredient(4913, 1);
			recipe.AddIngredient(211, 1);
			recipe.AddTile(114);
			recipe.Register();
		}
	}
}
