using System.ComponentModel;
using System.Collections.Generic;
using Terraria.ModLoader.Config;
using Terraria.ID;

namespace PowerUp.Common.Configs {
	public class PowerUpConfig : ModConfig {
		public override ConfigScope Mode => ConfigScope.ServerSide;
		
		public List<BuffDefinition> PossiblePowers = new List<BuffDefinition>() {
			new BuffDefinition(BuffID.Poisoned),
			new BuffDefinition(BuffID.Darkness),
			new BuffDefinition(BuffID.Cursed),
			new BuffDefinition(BuffID.OnFire),
			new BuffDefinition(BuffID.Bleeding),
			new BuffDefinition(BuffID.Confused),
			new BuffDefinition(BuffID.Slow),
			new BuffDefinition(BuffID.Weak),
			new BuffDefinition(BuffID.Silenced),
			new BuffDefinition(BuffID.BrokenArmor),
			new BuffDefinition(BuffID.Suffocation),
			
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
		
		[DefaultValue(10)]
		public int DropChance;
		
		[DefaultValue(30)]
		public int PowerDuration;
	}
}
