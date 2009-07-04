package fighter.controller.player.action 
{
	import fighter.model.game.Game;
	import fighter.model.player.Player;
	import fighter.view.Animations;
	
	import flash.utils.getQualifiedClassName;
	
	/**
	 * ...
	 * @author pgibler
	 */
	public class JumpRightAction implements Action
	{
		
		public function JumpRightAction()
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
				player.CurrentAnimation = player.PlayerAnimations.JumpBackward;
			}
			else
			{
				player.CurrentAnimation = player.PlayerAnimations.JumpForward;
			}
			player.CurrentAnimation.gotoAndStop(1);
			player.RunAnimation = true;
			player.XSpeed = player.WalkSpeed;
			player.YSpeed = -player.JumpSpeed;
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