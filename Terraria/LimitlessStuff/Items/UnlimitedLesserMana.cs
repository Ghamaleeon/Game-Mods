using Terraria;
using Terraria.ID;
using Terraria.ModLoader;
using Terraria.GameContent.Creative;

namespace LimitlessStuff.Items
{
	public class UnlimitedLesserMana : ModItem
	{
		public override void SetStaticDefaults()
		{
			DisplayName.SetDefault("Lesser Mana Catalyzer");
			Tooltip.SetDefault("Grants 100% reduced mana consumption\nBut also lowers your magic damage by 25%");
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
			player.GetDamage(DamageClass.Magic) -= 0.25f;
		}
		
		public override void AddRecipes()
		{
			Recipe recipe = CreateRecipe();
			recipe.AddIngredient(110, 50);
			recipe.AddTile(13);
			recipe.Register();
		}
	}
}