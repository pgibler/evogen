package fighter.controller.player.action 
{
	import fighter.model.game.Game;
	import fighter.model.player.Player;
	import fighter.view.CammyAnimations;
	
	import flash.display.MovieClip;
	import flash.utils.getQualifiedClassName;
	
	/**
	 * ...
	 * @author 
	 */
	public class AirIdleAction implements Action
	{
		
		public function AirIdleAction()
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
			return !player.OnGround;
		}
		
		public function PerformAction(player:Player, game:Game):Action
		{
			player.IsIdle = true;
			return this;
		}
		
		public function get FrameLag():int
		{
			return 1;
		}
		
		public function OnComplete(player:Player, game:Game):Action
		{
			if(!player.OnGround)
			{
				player.CurrentAction = this;
			}
			else
			{
				player.CurrentAction = new GroundIdleAction();
			}
			player.CurrentAction.PerformAction(player, game);
				
			return this;
		}
		
		private static var animation : MovieClip;
		
	}
	
}