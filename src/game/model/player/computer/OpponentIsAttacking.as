package game.model.player.computer 
{
	import flash.utils.getQualifiedClassName;
	import game.model.match.Match;
	import game.model.player.action.AvailableActions;
	import game.model.player.Player;
	
	/**
	 * ...
	 * @author pgibler
	 */
	public class OpponentIsAttacking implements Condition
	{
		
		public function OpponentIsAttacking()
		{
			this.name = getQualifiedClassName(this);
		}
		
		/* INTERFACE game.model.player.computer.Condition */
		
		public function EvaluateCondition(player:Player, match:Match):Boolean
		{
			return new IsAttackingCondition().EvaluateCondition(match.GetOpponentOf(player), match);
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