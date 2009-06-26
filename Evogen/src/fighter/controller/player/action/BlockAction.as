package fighter.controller.player.action 
{
	import fighter.model.game.Game;
	import fighter.model.player.Player;
	import fighter.view.CammyAnimations;
	
	import flash.utils.getQualifiedClassName;
	
	/**
	 * ...
	 * @author pgibler
	 */
	public class BlockAction implements Action
	{
		
		public function BlockAction()
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
			player.CurrentAnimation = player.PlayerAnimations.Block;
			player.CurrentAnimation.gotoAndStop(1);
			player.RunAnimation = true;
			player.IsBlocking = true;
			trace('blocking');
			return this;
		}
		
		public function get FrameLag():int
		{
			return 100;
		}
		
		public function OnComplete(player:Player, game:Game):Action
		{
			player.IsBlocking = false;
			return this;
		}
		
	}
	
}