package fighter.controller.player.production 
{
	import fighter.controller.player.action.Action;
	
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