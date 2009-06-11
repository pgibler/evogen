package game.model.player.action 
{
	import game.model.match.Match;
	import game.model.player.Player;
	
	/**
	 * ...
	 * @author pgibler
	 */
	public class JumpUpAction implements Action
	{
		
		public function IsValid(player:Player, match:Match):Boolean
		{
			return !player.IsAttacking && player.OnGround;
		}
		
		public function PerformAction(player:Player, match:Match):Player
		{
			return player;
		}
		
		public function FrameLag():int
		{
			return 10;
		}
		
	}
	
}