using System.ComponentModel;
using System.Collections.Generic;
using Terraria.ModLoader.Config;
using Terraria.ID;

namespace PowerUp.Common.Configs {
	public class PowerUpConfig : ModConfig {
		public override ConfigScope Mode => ConfigScope.ServerSide;
		
		public List<BuffDefinition> PossiblePowers = new List<BuffDefinition>() {
			new BuffDefinition(BuffID.ObsidianSkin),
			new BuffDefinition(BuffID.Regeneration),
			new BuffDefinition(BuffID.Swiftness),
			new BuffDefinition(BuffID.Ironskin),
			new BuffDefinition(BuffID.ManaRegeneration),
			new BuffDefinition(BuffID.MagicPower),
			new BuffDefinition(BuffID.Featherfall),
			new BuffDefinition(BuffID.Spelunker),
			new BuffDefinition(BuffID.Archery),
			new BuffDefinition(BuffID.Heartreach),
			new BuffDefinition(BuffID.Hunter),
			new BuffDefinition(BuffID.Endurance),
			new BuffDefinition(BuffID.Lifeforce),
			new BuffDefinition(BuffID.Inferno),
			new BuffDefinition(BuffID.Mining),
			new BuffDefinition(BuffID.Rage),
			new BuffDefinition(BuffID.Wrath),
			new BuffDefinition(BuffID.Dangersense)
		};
		
		[DefaultValue(15)]
		public int DropChance;
		
		[DefaultValue(60)]
		public int PowerDuration;
	}
}
