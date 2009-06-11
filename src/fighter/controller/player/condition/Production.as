package fighter.model.player.condition 
{
	import fighter.model.player.action.Action;
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
			this.actionSelectors = new Vector.<ActionSelector>();
		}
		
		public function SelectAction(conditionString:String):Action
		{
			var index : int = MathUtil.ConvertBinaryStringToBaseTenInteger(conditionString);
			return actionSelectors[index].SelectAction();
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