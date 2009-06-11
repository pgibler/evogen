package fighter.controller.player.production
{
	import fighter.controller.player.action.Action;
	import fighter.controller.player.condition.*;
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