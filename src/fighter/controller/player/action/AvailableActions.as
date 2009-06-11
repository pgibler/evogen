package fighter.controller.player.action 
{
	
	/**
	 * ...
	 * @author pgibler
	 */
	public class AvailableActions 
	{
		
		private static var returnme : Vector.<Action>;
		
		public static function GetAllActions():Vector.<Action>
		{
			if (returnme == null)
			{
				returnme = new Vector.<Class>();
				returnme.push(new JumpAwayAction());
				returnme.push(new JumpTowardsAction());
				returnme.push(new MoveAwayAction());
				returnme.push(new MoveTowardsAction());
				returnme.push(new GroundKickAction());
				returnme.push(new AirKickAction());
				returnme.push(new BlockAction());
				returnme.push(new AirIdleAction());
				returnme.push(new GroundIdleAction());
			}
			return returnme;
		}
		
	}
	
}