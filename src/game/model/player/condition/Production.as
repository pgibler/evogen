package game.model.player.condition 
{
	import game.model.player.action.Action;
	import game.util.MathUtil;
	
	/**
	 * ...
	 * @author 
	 */
	public class Production 
	{
		
		public function get Conditions():Vector.<Condition>
		{
			return conditions;
		}
		
		public function Production(conditions:Vector.<Condition>)
		{
			this.conditions = conditions;
		}
		
		public function SelectAction(conditionString:String):Action
		{
			var index : int = MathUtil.ConvertBinaryStringToDecimalInteger(conditionString);
			return actionSelectors[index].SelectAction();
		}
		
		public function AddRule(condition:String, actionSelector:ActionSelector):Production
		{
			conditionStrings.push(condition);
			actionSelectors.push(actionSelector);
			return this;
		}
		
		private var conditions : Vector.<Condition>;
		private var conditionStrings : Vector.<String>;
		private var actionSelectors : Vector.<ActionSelector>;
		
	}
	
}