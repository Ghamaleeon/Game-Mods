using System.ComponentModel;
using System.Collections.Generic;
using Terraria.ModLoader.Config;
using Terraria.ID;

namespace ChaosPickup.Common.Configs
{
	public class ChaosPickupConfig : ModConfig
	{
		public override ConfigScope Mode => ConfigScope.ServerSide;
		
		public List<BuffDefinition> PossibleBuffs = new List<BuffDefinition>() {
			new BuffDefinition(BuffID.ShadowDodge),
			new BuffDefinition(BuffID.WitheredArmor),
			new BuffDefinition(BuffID.NightOwl),
			new BuffDefinition(BuffID.Darkness)
		};
		
		[DefaultValue(5)]
		public int DropChance;
	}
}
