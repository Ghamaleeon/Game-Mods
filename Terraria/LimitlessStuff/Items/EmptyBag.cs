using Terraria;
using Terraria.ID;
using Terraria.ModLoader;
using Terraria.GameContent.Creative;

namespace LimitlessStuff.Items
{
	public class EmptyBag : ModItem
	{
		public override void SetStaticDefaults()
		{
			DisplayName.SetDefault("Empty Bag");
			Tooltip.SetDefault("Useful for compacting buff items");
			CreativeItemSacrificesCatalog.Instance.SacrificeCountNeededByItemId[Type] = 25;
		}
		
		public override void SetDefaults()
		{
			Item.maxStack = 99;
			Item.rare = 0;
			Item.value = 0;
		}

		public override void AddRecipes()
		{
			Recipe recipe = CreateRecipe();
			recipe.AddIngredient(ItemID.Silk, 10);
			recipe.AddTile(86);
			recipe.Register();
		}
	}
}
