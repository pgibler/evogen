package fighter.model.player.condition.human 
{
	import fighter.model.player.action.Action;
	import fighter.model.player.condition.Condition;
	import fighter.model.player.condition.JumpKeyDownCondition;
	import fighter.model.player.condition.KickKeyDownCondition;
	import fighter.model.player.condition.LeftKeyDownCondition;
	import fighter.model.player.condition.Production;
	import fighter.model.player.condition.ProductionTemplate;
	import fighter.model.player.condition.RightKeyDownCondition;
	import fighter.util.MathUtil;
	
	/**
	 * ...
	 * @author 
	 */
	public class HumanProductionTemplate extends ProductionTemplate
	{
		
		public function HumanProductionTemplate() 
		{
			super(Vector.<Condition>([	new LeftKeyDownCondition(),
										new RightKeyDownCondition(),
										new KickKeyDownCondition(),
										new JumpKeyDownCondition() ]));
		}
		
		override public function GenerateProduction():Production 
		{
			var prod : Production = new Production(this);
			var condCount : int = prod.Template.ConditionCombinations;
			for (var i : int = 0 ; i < condCount; i++)
			{
				var conditionString : String = MathUtil.ConvertBaseTenIntegerToBinaryString(i, Conditions.length);
				var actions : Vector.<Action> = GetIntersectionOfActions(conditionString);
				if (actions.length > 1)
				{
					trace(conditionString, actions);
					throw new Error("HumanProductionTemplate cannot generate a production with more than 1 action per intersection of conditions");
				}
				
			}
			return prod;
		}
		
	}
	
}