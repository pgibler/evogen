package game.model.player.computer 
{
	import game.model.match.Match;
	import game.model.player.action.Action;
	import game.model.player.Player;
	
	/**
	 * ...
	 * @author pgibler
	 */
	public interface Condition 
	{
		/**
		 * Determines if a condition is met based on the current state of the match.
		 * @param	player The player for which this condition is being evaluated.
		 * @param	match The match in which the battle is occuring. Information from this is used for validation.
		 * @return	True if the condition is met
		 */
		function EvaluateCondition(player:Player, match:Match):Boolean;
		/**
		 * Returns a vector containing the actions possible to perform when this condition is true.
		 */
		function get PossibleActionsWhenTrue():Vector.<Class>;
		/**
		 * Returns a vector containing the actions possible to perform when this condition is false.
		 */
		function get PossibleActionsWhenFalse():Vector.<Class>;
		/**
		 * Returns the name of the condition.
		 */
		function get Name():String;
	}
	
}