package fighter.controller.player.action 
{
	import fighter.model.game.Game;
	import fighter.model.player.Player;
	import flash.utils.getQualifiedClassName;
	
	/**
	 * ...
	 * @author pgibler
	 */
	public class AirKickAction implements Action
	{
		
		public function AirKickAction()
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
			player.IsAttacking = true;
			return this;
		}
		
		public function get FrameLag():int
		{
			return 40;
		}
		
		public function OnComplete(player:Player, game:Game):Action
		{
			player.IsAttacking = false;
			return this;
		}
		
	}
	
}