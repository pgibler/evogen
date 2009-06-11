package fighter.controller.player.action 
{
	import fighter.model.game.Game;
	import fighter.model.player.Player;
	
	/**
	 * ...
	 * @author pgibler
	 */
	public class BlockAction implements Action
	{
		
		public function IsValid(player:Player, game:Game):Boolean
		{
			return !player.OnGround && !player.IsAttacking;
		}
		
		public function PerformAction(player:Player, game:Game):Player
		{
			return player;
		}
		
		public function FrameLag():int
		{
			return 20;
		}
		
	}
	
}