package fighter.controller.player.action 
{
	import fighter.model.game.Game;
	import fighter.model.player.Player;
	
	/**
	 * ...
	 * @author 
	 */
	public class GroundIdleAction implements Action
	{
		
		/* INTERFACE fighter.controller.player.action.Action */
		
		public function IsValid(player:Player, game:Game):Boolean
		{
			return !player.IsAttacking && player.IsIdle;
		}
		
		public function PerformAction(player:Player, game:Game):Action
		{
			return this;
		}
		
		public function OnComplete(player:Player, game:Game):Action
		{
			return this;
		}
		
		public function get FrameLag():int
		{
			return 0;
		}
		
	}
	
}