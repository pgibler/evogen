package game.model.player.action 
{
	import game.model.match.Match;
	import game.model.player.Player;
	
	/**
	 * ...
	 * @author pgibler
	 */
	public class AirPunchAction implements Action
	{
		
		public function IsValid(player:Player, match:Match):Boolean
		{
			return !player.OnGround && !player.IsAttacking;
		}
		
		public function PerformAction(player:Player, match:Match):Player
		{
			return player;
		}
		
	}
	
}