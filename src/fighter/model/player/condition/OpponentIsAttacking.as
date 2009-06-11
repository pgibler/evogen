package fighter.model.player.condition 
{
	import flash.utils.getQualifiedClassName;
	import fighter.model.fighter.Game;
	import fighter.model.player.action.Action;
	import fighter.model.player.action.AvailableActions;
	import fighter.model.player.Player;
	
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
		
		/* INTERFACE fighter.model.player.computer.Condition */
		
		public function EvaluateCondition(player:Player, game:Game):Boolean
		{
			return player.CurrentOpponent.IsAttacking;
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