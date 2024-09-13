using System.Collections.Generic;
using System.Linq;
using Terraria;
using Terraria.ID;
using Terraria.Localization;
using Terraria.ModLoader;

namespace LimitlessStuff.Content
{
	public class LimitlessRecipeGroups : ModSystem
	{
		public static RecipeGroup WellFedRecipeGroup;

		public override void Unload() {
			WellFedRecipeGroup = null;
		}

		public override void AddRecipeGroups() {
			
			WellFedRecipeGroup = new RecipeGroup(() => $"{Language.GetTextValue("LegacyMisc.37")} {Lang.GetItemNameValue(ItemID.CookedMarshmallow)}",
				ItemID.CookedMarshmallow,
				ItemID.AppleJuice,
				ItemID.BloodyMoscato,
				ItemID.BunnyStew,
				ItemID.CookedFish,
				ItemID.BananaDaiquiri,
				ItemID.FruitJuice,
				ItemID.FruitSalad,
				ItemID.GrilledSquirrel,
				ItemID.Lemonade,
				ItemID.PeachSangria,
				ItemID.PinaColada,
				ItemID.RoastedBird,
				ItemID.SauteedFrogLegs,
				ItemID.SmoothieofDarkness,
				ItemID.TropicalSmoothie,
				ItemID.Teacup,
				ItemID.Apple,
				ItemID.Apricot,
				ItemID.Banana,
				ItemID.BlackCurrant,
				ItemID.BloodOrange,
				ItemID.Cherry,
				ItemID.Coconut,
				ItemID.Elderberry,
				ItemID.Grapefruit,
				ItemID.Lemon,
				ItemID.Mango,
				ItemID.Peach,
				ItemID.Pineapple,
				ItemID.Plum,
				ItemID.Rambutan,
				ItemID.MilkCarton,
				ItemID.PotatoChips,
				ItemID.ShuckedOyster,
				ItemID.Marshmallow);
			RecipeGroup.RegisterGroup("WellFed", WellFedRecipeGroup);
			
		}
	}
}