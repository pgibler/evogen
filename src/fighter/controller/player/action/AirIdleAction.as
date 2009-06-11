package fighter.controller.player.action 
{
	import fighter.model.game.Game;
	import fighter.model.player.Player;
	
	/**
	 * ...
	 * @author 
	 */
	public class AirIdleAction implements Action
	{
		
		/* INTERFACE fighter.controller.player.action.Action */
		
		public function IsValid(player:Player, game:Game):Boolean
		{
			return this;
		}
		
		public function PerformAction(player:Player, game:Game):Player
		{
			return this;
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