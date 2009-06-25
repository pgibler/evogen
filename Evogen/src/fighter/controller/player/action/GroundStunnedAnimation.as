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
			player.HitDamage = 0;
			player.IsStunned = true;
			player.XSpeed = -player.FacingDirection * player.WalkSpeed;
			player.CurrentAnimation = player.PlayerAnimations.Stunned;
			player.CurrentAnimation.gotoAndPlay(1);
			return this;
		}
		
		public function get FrameLag():int
		{
			return 20;
		}
		
		public function OnComplete(player:Player, game:Game):Action
		{
			player.IsStunned = false;
			player.OnGround ?
				new GroundIdleAction().PerformAction(player, game):
				new AirIdleAction().PerformAction(player, game);
			return this;
		}
		
		public function get Name():String
		{
			return name;
		}
		
		private var name : String;
	}
}