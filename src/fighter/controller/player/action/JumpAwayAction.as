package fighter.controller.player.action 
{
	import fighter.model.game.Game;
	import fighter.model.player.Player;
	
	/**
	 * ...
	 * @author pgibler
	 */
	public class JumpAwayAction implements Action
	{
		
		public function IsValid(player:Player, game:Game):Boolean
		{
			return !player.IsAttacking && player.OnGround;
		}
		
		public function PerformAction(player:Player, game:Game):Action
		{
			player.XSpeed = player.WalkSpeed * -1 * player.FacingDirection;
			player.YSpeed = player.JumpSpeed;
			return this;
		}
		
		public function get FrameLag():int
		{
			return 10;
		}
		
		public function OnComplete(player:Player, game:Game):Action
		{
			return this;
		}
		
	}
	
}