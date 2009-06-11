package fighter.model.player.action 
{
	import fighter.model.game.Game;
	import fighter.model.player.Player;
	
	/**
	 * ...
	 * @author pgibler
	 */
	public interface Action 
	{
		/**
		 * Checks to see if the action can be performed by the player given the current player state.
		 * @param	player The player who is trying to perform this action.
		 * @param	game The game in which the context of the validity of this move is being tested.
		 * @return	True if the action can be performed, otherwise false.
		 */
		function IsValid(player:Player, game:Game):Boolean;
		/**
		 * Performs the action as defined by the class.
		 * @param	player The player who is performing the action.
		 * @param	game The game in which this move is being performed
		 * @return	The action that was performed.
		 */
		function PerformAction(player:Player, game:Game):Action;
		/**
		 * Returns the number of frames that must occur before another move can be performed.
		 * @return The number of frames that must occur before another move can be performed.
		 */
		function get FrameLag():int;
		/**
		 * Callback that gets activated when this action finished executing, i.e. the frame lag is over.
		 * @param	player The player whose action is complete.
		 * @param	game The game in which the action was occuring.
		 * @return	Returns this action.
		 */
		function OnComplete(player:Player, game:Game):Action;
	}
	
}