package game.model.player.condition 
{
	import flash.errors.IllegalOperationError;
	import game.model.player.action.Action;
	
	/**
	 * ...
	 * @author 
	 */
	public class ProductionTemplate 
	{
		
		protected function get Conditions():Vector.<Condition>
		{
			return conditions;
		}
		
		public function ProductionTemplate()
		{
			var conditions : Vector.<Condition> = new Vector.<Condition>();
		}
		
		public function GenerateProduction():Production
		{
			throw new IllegalOperationError("GenerateProduction must be implemented");
			return null;
		}
	
		private function GetValidActions(condition:Condition, state:Boolean):Vector.<Action>
		{
			return (state) ? condition.PossibleActionsWhenTrue : condition.PossibleActionsWhenFalse;
		}
		
		private function GetIntersectionOfActions(conditionString : String):Vector.<Action>
		{
			var actionVectors : Vector.<Class> = new Vector.<Action>();
			
			for (var j : int = 0; j < conditionString.length; j++)
			{
				var validity : Boolean = conditionString.charAt(j) == "1";
				var conditionActions : Vector.<Class> = (validity) ? conditions[j].PossibleActionsWhenTrue : conditions[j].PossibleActionsWhenFalse;
				actions.push(conditionActions);
			}
			
			var actions : Vector.<Action> = actionVectors[0];
			
			for (var i : int = 1; i < actionVectors.length; i++)
			{
				actions.filter(function(item:*, index:int, array:Array) {
					return array.indexOf(item) != -1;
				});
			}
			return actions;
		}
		
		private var conditions : Vector.<Condition>;
		
		private var conditionStrings : Vector.<String>;
		private var actionSelectors : Vector.<ActionSelector>;
		
	}
	
}