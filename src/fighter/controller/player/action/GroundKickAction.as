package fighter.controller.player.action 
{
	import fighter.model.game.Game;
	import fighter.model.player.Player;
	
	/**
	 * ...
	 * @author pgibler
	 */
	public class GroundKickAction implements Action
	{
		
		public function IsValid(player:Player, game:Game):Boolean
		{
			return player.OnGround && !player.IsAttacking;
		}
		
		public function PerformAction(player:Player, game:Game):Action
		{
			player.IsAttacking = true;
			return this;
		}
		
		public function OnComplete(player:Player, game:Game):Action
		{
			player.IsAttacking = false;
			return this;
		}
		
		public function get FrameLag():int
		{
			return 100;
		}
		
	}
	
}