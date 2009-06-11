package game.model.player.condition.computer 
{
	import game.model.player.action.Action;
	import game.model.player.condition.ActionSelector;
	
	/**
	 * ...
	 * @author pgibler
	 */
	public class ActionProbabilityMap implements ActionSelector
	{
		
		public function ActionProbabilityMap(actions:Vector.<Action>, actionProbabilities:Vector.<Number>) 
		{
			this.actions = actions;
			this.actionProbabilities = actionProbabilities;
		}
		
		public function AddActionProbability(action:Action, actionProbability:Number):ActionProbabilityMap
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