package fighter.controller.player.action 
{
	import fighter.model.game.Game;
	import fighter.model.player.Player;
	import flash.utils.getQualifiedClassName;
	
	/**
	 * ...
	 * @author pgibler
	 */
	public class MoveTowardsAction implements Action
	{
		
		public function MoveTowardsAction()
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
			player.IsIdle = false;
			if (player.Position.x > player.CurrentOpponent.Position.x)
			{
				player.Position.x -= player.WalkSpeed;
			}
			else
			{
				player.Position.x += player.WalkSpeed;
			}
			return this;
		}
		
		public function OnComplete(player:Player, game:Game):Action
		{
			player.IsIdle = true;
			return this;
		}
		
		public function get FrameLag():int
		{
			return 0;
		}
		
	}
	
}