package fighter.controller.player.production
{
	import fighter.controller.player.action.Action;
	import fighter.controller.player.condition.Condition;
	import fighter.util.MathUtil;
	
	/**
	 * ...
	 * @author 
	 */
	public class Production 
	{
		
		public function get Conditions():Vector.<Condition>
		{
			return this.conditions;
		}
		public function get Template():ProductionTemplate
		{
			return this.productionTemplate;
		}
		
		public function Production(productionTemplate:ProductionTemplate)
		{
			this.productionTemplate = productionTemplate;
			this.conditions = productionTemplate.Conditions;
			this.conditionStrings = new Vector.<String>();
			this.actionSelectors = new Vector.<ActionSelector>();
		}
		
		public function SelectAction(conditionString:String):Action
		{
			var index : int = MathUtil.ConvertBinaryStringToBaseTenInteger(conditionString);
			trace(index);
			var actionSelector : ActionSelector = actionSelectors[index];
			var a : Action = actionSelector == null ? null : actionSelector.SelectAction();
			return a;
		}
		
		public function AddRule(condition:String, actionSelector:ActionSelector):Production
		{
			conditionStrings.push(condition);
			actionSelectors.push(actionSelector);
			return this;
		}
		
		private var productionTemplate : ProductionTemplate;
		private var conditions : Vector.<Condition>;
		private var conditionStrings : Vector.<String>;
		private var actionSelectors : Vector.<ActionSelector>;
		
	}
	
}