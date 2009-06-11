package fighter.model.player.condition 
{
	import fighter.model.player.action.Action;
	
	/**
	 * ...
	 * @author 
	 */
	public interface ActionSelector 
	{
		/**
		 * Selects an action and returns it.
		 * @return	An action that has been selected.
		 */
		function SelectAction():Action;
	}
	
}