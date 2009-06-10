package game.model.player.action 
{
	
	/**
	 * ...
	 * @author pgibler
	 */
	public class AvailableActions 
	{
		
		private static var returnme : Vector.<Class>;
		
		public static function GetAllActions():Vector.<Class>
		{
			if (returnme == null)
			{
				returnme = new Vector.<Class>();
				returnme.push(JumpAwayAction);
				returnme.push(JumpTowardsAction);
				returnme.push(JumpUpAction);
				returnme.push(MoveAwayAction);
				returnme.push(MoveTowardsAction);
				returnme.push(GroundKickAction);
				returnme.push(GroundPunchAction);
				returnme.push(AirPunchAction);
				returnme.push(AirKickAction);
			}
			return returnme;
		}
		
	}
	
}