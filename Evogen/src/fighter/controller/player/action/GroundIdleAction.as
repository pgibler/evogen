﻿package fighter.controller.player.action 
{
	import fighter.model.game.Game;
	import fighter.model.player.Player;
	import fighter.util.Animations;
	
	import flash.display.MovieClip;
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
			return player.OnGround;
		}
		
		public function PerformAction(player:Player, game:Game):Action
		{
			if(player.CurrentAnimation !== Animations.Instance.CammyIdle)
			{
				player.CurrentAnimation = Animations.Instance.CammyIdle;
				player.CurrentAnimation.play();
			}
			player.FacePlayer(player.CurrentOpponent);
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
		
		private static var animation : MovieClip;
		
	}
	
}