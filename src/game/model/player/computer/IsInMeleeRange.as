C:\Users\Administrator\Programming\FlashDevelop\Evogen\src\game\model\player\computer\IsInMeleeRange.as

package game.model.player.computer 
{
	import flash.geom.Point;
	import flash.utils.getQualifiedClassName;
	import game.model.match.Match;
	import game.model.player.action.AvailableActions;
	import game.model.player.Player;
	
	/**
	 * ...
	 * @author pgibler
	 */
	public class IsInMeleeRange implements Condition
	{
		
		public function IsInMeleeRange() 
		{
			this.name = getQualifiedClassName(this);
		}
		
		/* INTERFACE game.model.player.computer.Condition */
		
		public function EvaluateCondition(player:Player, match:Match):Boolean
		{
			return Point.distance(player.CurrentOpponent.Position, player.Position) < 20;
		}
		
		public function get PossibleActionsWhenTrue():Vector.<Class>
		{
			return AvailableActions.GetAllActions();
		}
		
		public function get PossibleActionsWhenFalse():Vector.<Class>
		{
			return AvailableActions.GetAllActions();
		}
		
		private var name : String;
		
	}
	
}