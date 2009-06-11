package fighter.model.player.action 
{
	import fighter.model.game.Game;
	import fighter.model.player.Player;
	
	/**
	 * ...
	 * @author 
	 */
	public class GroundIdleAction implements Action
	{
		
		/* INTERFACE fighter.model.player.action.Action */
		
		public function IsValid(player:Player, game:Game):Boolean
		{
			
		}
		
		public function PerformAction(player:Player, game:Game):Player
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