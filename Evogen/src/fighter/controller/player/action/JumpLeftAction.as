package fighter.controller.player.action 
{
	import fighter.model.game.Game;
	import fighter.model.player.Player;
	import fighter.util.Animations;
	
	import flash.utils.getQualifiedClassName;
	
	/**
	 * ...
	 * @author pgibler
	 */
	public class JumpLeftAction implements Action
	{
		
		public function JumpLeftAction()
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
			return !player.IsAttacking && player.OnGround;
		}
		
		public function PerformAction(player:Player, game:Game):Action
		{
			//player.CurrentAnimation.gotoAndPlay(1);
			
			var angle : Number = 70;
			var jumpX : Number = Math.cos(angle) * player.JumpSpeed;
			var jumpY : Number = Math.sin(angle) * player.JumpSpeed;
			player.XSpeed = jumpX;
			player.YSpeed = -jumpY;
			return this;
		}
		
		public function get FrameLag():int
		{
			return 15;
		}
		
		public function OnComplete(player:Player, game:Game):Action
		{
			return this;
		}
		
	}
	
}