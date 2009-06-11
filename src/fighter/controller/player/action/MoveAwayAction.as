﻿package fighter.controller.player.action 
{
	import fighter.model.game.Game;
	import fighter.model.player.Player;
	
	/**
	 * ...
	 * @author pgibler
	 */
	public class MoveAwayAction implements Action
	{
		
		public function IsValid(player:Player, game:Game):Boolean
		{
			return !player.IsAttacking && player.OnGround;
		}
		
		public function PerformAction(player:Player, game:Game):Action
		{
			if (player.Position.x > player.CurrentOpponent.Position.x)
			{
				player.Position.x += player.WalkSpeed;
			}
			else
			{
				player.Position.x -= player.WalkSpeed;
			}
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