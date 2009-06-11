package game.model.player.condition 
{
	import flash.utils.getQualifiedClassName;
	import game.model.player.action.Action;
	import game.model.player.action.AvailableActions;
	import game.model.player.Player;
	import game.model.match.Match;
	
	/**
	 * ...
	 * @author pgibler
	 */
	public class OpponentIsOnGroundCondition implements Condition
	{
		
		public function OpponentIsOnGroundCondition()
		{
			this.name = getQualifiedClassName(this);
		}
		
		/* INTERFACE game.model.player.computer.Condition */
		
		public function EvaluateCondition(player:Player, match:Match):Boolean
		{
			return player.CurrentOpponent.OnGround;
		}
		
		public function get Name():String
		{
			return name;
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