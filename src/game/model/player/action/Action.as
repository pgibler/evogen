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
		 * Performs the action as defined by the class.
		 * @param	player The player who is performing the action.
		 * @param	match The match in which this move is being performed
		 * @return	The player performing the action.
		 */
		function PerformAction(player:Player, match:Match):Player;
		/**
		 * Returns the number of frames that must occur before another move can be performed.
		 * @return The number of frames that must occur before another move can be performed.
		 */
		function get FrameLag():int;
		/**
		 * Callback that gets activated when this action finished executing, i.e. the frame lag is over.
		 * @return	The action that this returns to.
		 */
		function OnComplete():Action;
	}
	
}