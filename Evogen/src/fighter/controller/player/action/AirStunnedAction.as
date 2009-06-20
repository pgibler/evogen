package fighter.controller.player.action
{
	import fighter.model.game.Game;
	import fighter.model.player.Player;
	
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
			player.IsStunned = true;
			return this;
		}
		
		public function get FrameLag():int
		{
			return 10;
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