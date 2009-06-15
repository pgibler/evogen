package fighter.controller.player.production
{
	import fighter.controller.player.action.Action;
	import fighter.controller.player.condition.Condition;
	
	import flash.errors.IllegalOperationError;
	
	/**
	 * ...
	 * @author 
	 */
	public class ProductionTemplate 
	{
		
		public function get ConditionCombinations():Number
		{
			return Math.pow(2, Conditions.length-1);
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
			var isTrue : Boolean = conditionString.charAt(0) == "1";
			var leastCondition : Condition = conditions[0];
			var leastActions : Vector.<Action> = isTrue ? leastCondition.PossibleActionsWhenTrue : leastCondition.PossibleActionsWhenFalse;
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
					actionVectors.push(leastActions);
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
			var leastActionNames : Vector.<String> = new Vector.<String>();
			leastActions.forEach(function(item:Action, index:int, array:Vector.<Action>):void
			{
				leastActionNames.push( item.Name );
			});
			for (i = 0; i < actionVectors.length; i++)
			{
				currentActions = actionVectors[i];
				leastActions = currentActions.filter(function(item:Action, index:int, array:Vector.<Action>):Boolean {
					return leastActionNames.indexOf(item.Name) != -1;
				});
			}
			return leastActions;
		}
		
		private var conditions : Vector.<Condition>;
		
		private var conditionStrings : Vector.<String>;
		private var actionSelectors : Vector.<ActionSelector>;
		
	}
	
}