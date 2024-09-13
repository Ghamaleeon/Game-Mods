using Terraria;
using Terraria.ID;
using Terraria.ModLoader;
using Terraria.GameContent.Creative;

namespace LimitlessStuff.Items
{
	public class UnlimitedDarkHarvest : ModItem
	{
		public override void SetStaticDefaults()
		{
			DisplayName.SetDefault("Dark Harvest's Handle");
			Tooltip.SetDefault("Grants Harvest Time buff");
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
			player.AddBuff(311, 1);
		}

		public override void AddRecipes()
		{
			Recipe recipe = CreateRecipe();
			recipe.AddIngredient(4680, 1);
			recipe.AddIngredient(ModContent.ItemType<UnlimitedDurendal>(), 1);
			recipe.AddTile(114);
			recipe.Register();
		}
	}
}
