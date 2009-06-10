package game.model.player.action 
{
	import game.model.match.Match;
	import game.model.player.Player;
	
	/**
	 * ...
	 * @author pgibler
	 */
	public interface Action 
	{
		/**
		 * Checks to see if the action can be performed by the player given the current player state.
		 * @param	player The player who is trying to perform this action.
		 * @param	match The match in which the context of the validity of this move is being tested.
		 * @return	True if the action can be performed, otherwise false.
		 */
		function IsValid(player:Player, match:Match):Boolean;
		/**
		 * 
		 * @param	player The player who is performing the action.
		 * @param	match The match in which this move is being performed
		 * @return	The player performing the action.
		 */
		function PerformAction(player:Player, match:Match):Player;
	}
	
}