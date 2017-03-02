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
			var i : int = 0;
			for (; i < actions.length; i++)
			{
				total += actionProbabilities[i];
				if (total > prob)
				{
					return actions[i];
				}
			}
			// This is to handle floating point error.
			// In rare cases, the random number is greater than the total probabilities
			return actions[actions.length-1];
		}
		
		private var actions : Vector.<Action>;
		private var actionProbabilities : Vector.<Number>;
		
	}
	
}