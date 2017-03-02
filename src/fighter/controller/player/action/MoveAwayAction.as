﻿package fighter.controller.player.action 
{
	import fighter.model.game.Game;
	import fighter.model.player.Player;
	import fighter.view.CammyAnimations;
	
	import flash.utils.getQualifiedClassName;
	
	/**
	 * ...
	 * @author pgibler
	 */
	public class MoveAwayAction implements Action
	{
		
		public function MoveAwayAction()
		{
			this.name = getQualifiedClassName(this);
		}
		
		private var name : String;
		
		public function get Name():String
		{
			return name;
		}
		
		public function IsValid(player:Player, game:Game):Boolean
		{
			return !player.IsAttacking && player.OnGround && !player.IsStunned;
		}
		
		public function PerformAction(player:Player, game:Game):Action
		{
			if(player.Position.x > player.CurrentOpponent.Position.x)
			{
				player.Position.x += player.WalkSpeed;
			}
			else
			{
				player.Position.x -= player.WalkSpeed;
			}
			player.CurrentAnimation = player.PlayerAnimations.WalkBackward;
			return this;
		}
		
		public function OnComplete(player:Player, game:Game):Action
		{
			return this;
		}
		
		public function get FrameLag():int
		{
			return 1;
		}
		
	}
	
}