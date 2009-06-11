package fighter.model.player.condition.human 
{
	import fighter.model.player.action.Action;
	import fighter.model.player.condition.ActionSelector;
	
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