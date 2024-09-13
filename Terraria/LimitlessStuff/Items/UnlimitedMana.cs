using Terraria;
using Terraria.ID;
using Terraria.ModLoader;
using Terraria.GameContent.Creative;

namespace LimitlessStuff.Items
{
	public class UnlimitedMana : ModItem
	{
		public override void SetStaticDefaults()
		{
			DisplayName.SetDefault("Mana Catalyzer");
			Tooltip.SetDefault("Grants 100% reduced mana consumption\nBut also lowers your magic damage by 20%");
			CreativeItemSacrificesCatalog.Instance.SacrificeCountNeededByItemId[Type] = 1;
		}
		
		public override void SetDefaults()
		{
			Item.maxStack = 1;
			Item.rare = 1;
			Item.value = 0;
			Item.accessory = true;
		}
		
		public override void UpdateInventory(Player player)
		{
			player.manaCost -= 1f;
			player.GetDamage(DamageClass.Magic) -= 0.20f;
		}
		
		public override void AddRecipes()
		{
			Recipe recipe = CreateRecipe();
			recipe.AddIngredient(189, 75);
			recipe.AddIngredient(ModContent.ItemType<UnlimitedLesserMana>(), 1);
			recipe.AddTile(355);
			recipe.Register();
		}
	}
}