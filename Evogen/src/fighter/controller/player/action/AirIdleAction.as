package fighter.controller.player.action 
{
	import fighter.model.game.Game;
	import fighter.model.player.Player;
	
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
			player.CurrentAnimation = animation;
			animation.play();
			return this;
		}
		
		public function get FrameLag():int
		{
			animation.stop();
			return 0;
		}
		
		public function OnComplete(player:Player, game:Game):Action
		{
			player.OnGround ?
				new GroundIdleAction().PerformAction(player, game):
				this.PerformAction(player, game);
			return this;
		}
		
		private static var animation : MovieClip;
		
	}
	
}