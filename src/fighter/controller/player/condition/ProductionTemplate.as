package fighter.model.player.condition 
{
	import flash.errors.IllegalOperationError;
	import fighter.model.player.action.Action;
	
	/**
	 * ...
	 * @author 
	 */
	public class ProductionTemplate 
	{
		
		public function get ConditionCombinations():Number
		{
			return Math.pow(2, Conditions.length);
		}
		
		public function get Conditions():Vector.<Condition>
		{
			return conditions;
		}
		
		public function ProductionTemplate(conditions:Vector.<Condition>)
		{
			this.conditions = conditions;
		}
		
		public function GenerateProduction():Production
		{
			throw new IllegalOperationError("GenerateProduction must be implemented");
			return null;
		}
	
		protected function GetValidActions(condition:Condition, state:Boolean):Vector.<Action>
		{
			return (state) ? condition.PossibleActionsWhenTrue : condition.PossibleActionsWhenFalse;
		}
		
		protected function GetIntersectionOfActions(conditionString : String):Vector.<Action>
		{
			var actionVectors : Vector.<Vector.<Action>> = new Vector.<Vector.<Action>>();
			
			// First, get the condition that has the least possible actions.
			var leastCondition : Condition = conditions[0];
			var leastActions : Vector.<Action> = conditionString.charAt(0) == "1" ? leastCondition.PossibleActionsWhenTrue : leastCondition.PossibleActionsWhenFalse;
			var leastLen : int = leastActions.length;
			var condIndex : int = 0;
			var changed : Boolean = false;
			var i:int;
			var currentActions : Vector.<Action>
			for (i = 1; i < conditionString.length; i++)
			{
				var validity : Boolean = conditionString.charAt(i) == "1";
				var currentCond : Condition = conditions[i];
				currentActions = validity ? currentCond.PossibleActionsWhenTrue : currentCond.PossibleActionsWhenFalse;
				if(currentActions.length < leastLen)
				{
					leastActions = currentActions;
					changed = true;
				}
				if (changed)
				{
					leastLen = leastActions.length;
					leastCondition = currentCond;
					condIndex = i;
					changed = false;
				}
				else
				{
					actionVectors.push(currentActions);
				}
			}
			
			for (i = 0; i < actionVectors.length; i++)
			{
				currentActions = actionVectors[i];
				leastActions.filter(function(item:*, index:int, array:Vector.<Action>):Boolean {
					return currentActions.indexOf(item) != -1;
				});
			}
			return leastActions;
		}
		
		private var conditions : Vector.<Condition>;
		
		private var conditionStrings : Vector.<String>;
		private var actionSelectors : Vector.<ActionSelector>;
		
	}
	
}