package fighter.controller.player.action
{
	import fighter.model.game.Game;
	import fighter.model.player.Player;
	
	import flash.utils.getQualifiedClassName;
	
	public class GroundStunnedAnimation implements Action
	{
		
		public function GroundStunnedAnimation()
		{
			this.name = getQualifiedClassName(this);
		}
		
		public function IsValid(player:Player, game:Game):Boolean
		{
			return player.OnGround;
		}
		
		public function PerformAction(player:Player, game:Game):Action
		{
			trace("stunned");
			player.HitDamage = 0;
			player.IsStunned = true;
			player.IsAttacking = false;
			player.IsBlocking = false;
			player.XSpeed = player.FacingDirection * player.WalkSpeed;
			player.CurrentAnimation = player.PlayerAnimations.Stunned;
			player.CurrentAnimation.gotoAndStop(1);
			player.RunAnimation = true;
			return this;
		}
		
		public function get FrameLag():int
		{
			return 20;
		}
		
		public function OnComplete(player:Player, game:Game):Action
		{
			player.IsStunned = false;
			player.CurrentAction = new GroundIdleAction();
			player.CurrentAction.PerformAction(player, game)
			return this;
		}
		
		public function get Name():String
		{
			return name;
		}
		
		private var name : String;
	}
}