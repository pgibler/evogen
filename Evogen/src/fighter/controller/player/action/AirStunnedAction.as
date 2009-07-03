package fighter.controller.player.action
{
	import fighter.model.game.Game;
	import fighter.model.player.Player;
	import fighter.view.CammyAnimations;
	
	import flash.utils.getQualifiedClassName;
	
	public class AirStunnedAction implements Action
	{
		
		public function AirStunnedAction()
		{
			this.name = getQualifiedClassName(this);
		}
		
		public function IsValid(player:Player, game:Game):Boolean
		{
			return !player.OnGround;
		}
		
		public function PerformAction(player:Player, game:Game):Action
		{
			player.HitDamage = 0;
			player.IsStunned = true;
			player.IsAttacking = false;
			player.IsBlocking = false;
			player.XSpeed = -player.FacingDirection * player.WalkSpeed;
			player.CurrentAnimation = player.PlayerAnimations.Stunned;
			player.CurrentAnimation.gotoAndStop(1);
			player.RunAnimation = true;
			return this;
		}
		
		public function get FrameLag():int
		{
			return 1;
		}
		
		public function OnComplete(player:Player, game:Game):Action
		{
			if(player.OnGround)
			{
				player.IsStunned = false;
			}
			else
			{
				player.FrameLag = 1;
			}
			
			return this;
		}
		public function get Name():String
		{
			return name;
		}
		
		private var name : String;
	}
}