using System.ComponentModel;
using System.Collections.Generic;
using Terraria.ModLoader.Config;

namespace EnemyValue.Common.Configs {
	public class EnemyValueConfig : ModConfig {
		public override ConfigScope Mode => ConfigScope.ServerSide;
		
		[Range(0f, 10f)]
		[Increment(.1f)]
		[DrawTicks]
		[DefaultValue(1f)]
		[Slider]
		public float ValueMultiplier;
	}
}
