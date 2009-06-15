package fighter.controller.player.production
{
	import fighter.controller.player.action.Action;
	
	/**
	 * ...
	 * @author pgibler
	 */
	public class ProbabilisticActionSelector implements ActionSelector
	{
		
		public function ProbabilisticActionSelector(actions:Vector.<Action>, actionProbabilities:Vector.<Number>) 
		{
			this.actions = actions;
			this.actionProbabilities = actionProbabilities;
		}
		
		public function SelectAction():Action
		{
			var prob : Number = Math.random();
			var total : Number = 0;
			for (var i : int = 0; i < actions.length; i++)
			{
				total += actionProbabilities[i];
				if (total > prob)
				{
					return actions[i];
				}
			}
			throw new Error("Could not select action successfully");
		}
		
		private var actions : Vector.<Action>;
		private var actionProbabilities : Vector.<Number>;
		
	}
	
}