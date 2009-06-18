package fighter.controller.player.action 
{
	import fighter.model.game.Game;
	import fighter.model.player.Player;
	import flash.utils.getQualifiedClassName;
	
	/**
	 * ...
	 * @author pgibler
	 */
	public class JumpUpAction implements Action
	{
		
		public function JumpUpAction()
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
			var angle : Number = 70;
			var jumpX : Number = -player.FacingDirection * Math.cos(angle) * player.JumpSpeed;
			var jumpY : Number = Math.sin(angle) * player.JumpSpeed;
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