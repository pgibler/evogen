﻿package fighter.controller.player.action 
{
	import fighter.model.game.Game;
	import fighter.model.player.Player;
	import flash.utils.getQualifiedClassName;
	
	/**
	 * ...
	 * @author 
	 */
	public class GroundIdleAction implements Action
	{
		
		public function GroundIdleAction()
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