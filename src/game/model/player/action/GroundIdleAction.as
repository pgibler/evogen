package game.model.player.action 
{
	import game.model.match.Match;
	import game.model.player.Player;
	
	/**
	 * ...
	 * @author 
	 */
	public class GroundIdleAction implements Action
	{
		
		/* INTERFACE game.model.player.action.Action */
		
		public function IsValid(player:Player, match:Match):Boolean
		{
			
		}
		
		public function PerformAction(player:Player, match:Match):Player
		{
			
		}
		
		public function get FrameLag():int
		{
			return 0;
		}
		
		public function OnComplete():Action
		{
			return this;
		}
		
	}
	
}