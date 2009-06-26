package fighter.controller.player.action 
{
	import fighter.model.game.Game;
	import fighter.model.player.Player;
	
	import flash.utils.getQualifiedClassName;
	
	/**
	 * ...
	 * @author pgibler
	 */
	public class GroundMediumPunchAction implements Action
	{
		
		public function GroundMediumPunchAction()
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
			return player.OnGround && !player.IsAttacking;
		}
		
		public function PerformAction(player:Player, game:Game):Action
		{
			player.CurrentAnimation = player.PlayerAnimations.GroundMediumPunch;
			player.CurrentAnimation.gotoAndStop(1);
			player.RunAnimation = true;
			
			player.IsAttacking = true;
			return this;
		}
		
		public function OnComplete(player:Player, game:Game):Action
		{
			player.IsAttacking = false;
			return this;
		}
		
		public function get FrameLag():int
		{
			return 30;
		}
		
	}
	
}