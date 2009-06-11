package fighter.model.player.condition 
{
	import flash.geom.Point;
	import flash.utils.getQualifiedClassName;
	import fighter.model.fighter.Game;
	import fighter.model.player.action.Action;
	import fighter.model.player.action.AvailableActions;
	import fighter.model.player.Player;
	
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
		
		/* INTERFACE fighter.model.player.computer.Condition */
		
		public function EvaluateCondition(player:Player, game:Game):Boolean
		{
			return Point.distance(player.CurrentOpponent.Position, player.Position) < 20;
		}
		
		public function get PossibleActionsWhenTrue():Vector.<Action>
		{
			return AvailableActions.GetAllActions();
		}
		
		public function get PossibleActionsWhenFalse():Vector.<Action>
		{
			return AvailableActions.GetAllActions();
		}
		
		private var name : String;
		
	}
	
}