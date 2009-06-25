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
			player.XSpeed = -player.FacingDirection * player.WalkSpeed;
			player.CurrentAnimation = player.PlayerAnimations.Stunned;
			player.CurrentAnimation.gotoAndPlay(1);
			return this;
		}
		
		public function get FrameLag():int
		{
			return 50;
		}
		
		public function OnComplete(player:Player, game:Game):Action
		{
			player.IsStunned = false;
			return this;
		}
		
		public function get Name():String
		{
			return name;
		}
		
		private var name : String;
	}
}