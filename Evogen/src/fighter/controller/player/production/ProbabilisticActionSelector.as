package fighter.controller.player.production
{
	import fighter.controller.player.action.Action;
	import fighter.controller.player.condition.ActionSelector;
	
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
		
		public function AddActionProbabilistic(action:Action, actionProbability:Number):ProbabilisticActionSelector
		{
			actions.push(action);
			actionProbabilities.push(actionProbability);
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
		}
		
		private var actions : Vector.<Action>;
		private var actionProbabilities : Vector.<Number>;
		
	}
	
}