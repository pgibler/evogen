package fighter.model.player.condition 
{
	import fighter.model.game.Game;
	import fighter.model.player.action.Action;
	import fighter.model.player.Player;
	
	/**
	 * ...
	 * @author pgibler
	 */
	public interface Condition 
	{
		/**
		 * Determines if a condition is met based on the current state of the fighter.
		 * @param	player The player for which this condition is being evaluated.
		 * @param	game The game in which the battle is occuring. Information from this is used for validation.
		 * @return	True if the condition is met
		 */
		function EvaluateCondition(player:Player, game:Game):Boolean;
		/**
		 * Returns a vector containing the actions possible to perform when this condition is true.
		 */
		function get PossibleActionsWhenTrue():Vector.<Action>;
		/**
		 * Returns a vector containing the actions possible to perform when this condition is false.
		 */
		function get PossibleActionsWhenFalse():Vector.<Action>;
		/**
		 * Returns the name of the condition.
		 */
		function get Name():String;
	}
	
}