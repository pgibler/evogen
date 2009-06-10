package game.model.player.computer 
{
	import game.model.player.action.Action;
	
	/**
	 * ...
	 * @author pgibler
	 */
	public class ActionProbabilityMap 
	{
		
		public function ActionProbabilityMap(actions:Vector.<Class>, actionProbabilities:Vector.<Number>) 
		{
			this.actions = actions;
			this.actionProbabilities = actionProbabilities;
		}
		
		public function AddActionProbability(action:Class, actionProbability:Number):ActionProbabilityMap
		{
			actions.push(action);
			actionProbabilities.push(actionProbability);
		}
		
		private var actions : Vector.<Class>;
		private var actionProbabilities : Vector.<Number>;
		
	}
	
}