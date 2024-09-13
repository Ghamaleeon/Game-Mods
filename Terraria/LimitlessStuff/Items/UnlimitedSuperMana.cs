using Terraria;
using Terraria.ID;
using Terraria.ModLoader;
using Terraria.GameContent.Creative;

namespace LimitlessStuff.Items
{
	public class UnlimitedSuperMana : ModItem
	{
		public override void SetStaticDefaults()
		{
			DisplayName.SetDefault("Super Mana Catalyzer");
			Tooltip.SetDefault("Grants 100% reduced mana consumption\nBut also lowers your magic damage by 10%");
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
			player.manaCost -= 1f;
			player.GetDamage(DamageClass.Magic) -= 0.10f;
		}
		
		public override void AddRecipes()
		{
			Recipe recipe = CreateRecipe();
			recipe.AddIngredient(2209, 99);
			recipe.AddIngredient(ModContent.ItemType<UnlimitedGreaterMana>(), 1);
			recipe.AddTile(412);
			recipe.Register();
		}
	}
}