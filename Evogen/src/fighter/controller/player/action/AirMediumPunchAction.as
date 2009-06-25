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
	public class AirMediumPunchAction implements Action
	{
		
		public function AirMediumPunchAction()
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
			return !player.OnGround && !player.IsAttacking;
		}
		
		public function PerformAction(player:Player, game:Game):Action
		{
			player.CurrentAnimation = Animations.Instance.CammyAirMediumPunch;
			player.CurrentAnimation.gotoAndPlay(1);
			player.IsAttacking = true;
			player.HitDamage = 12;
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
				player.IsAttacking = false;
				player.HitDamage = 0;
				new GroundIdleAction().PerformAction(player, game)
			}
			else
			{
				player.FrameLag = 1;
			}
			return this;
		}
		
	}
	
}