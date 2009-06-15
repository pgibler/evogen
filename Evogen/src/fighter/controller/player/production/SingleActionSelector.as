package fighter.controller.player.production
{
	import fighter.controller.player.action.Action;
	
	/**
	 * ...
	 * @author 
	 */
	public class SingleActionSelector implements ActionSelector
	{
		
		public function SingleActionSelector(action:Action) 
		{
			this.action = action;
		}
		
		public function SelectAction():Action
		{
			return action;
		}
		
		private var action : Action;
		
	}
	
}