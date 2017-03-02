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
										new JumpKeyDownCondition(),
										new KickKeyDownCondition(),
										new BlockKeyDownCondition(),
										new IsToLeftOfOpponentCondition(),
										new IsOnGroundCondition()]));
		}
		
		override public function GenerateProduction():Production 
		{
			var prod : Production = new Production(this);
			var condCount : int = prod.Template.ConditionCombinations;
			for (var i : int = 0 ; i < condCount; i++)
			{
				var conditionString : String = MathUtil.ConvertBaseTenIntegerToBinaryString(i, Conditions.length-1);
				var actions : Vector.<Action> = GetIntersectionOfActions(conditionString);
				if (actions.length == 1)
				{
					prod.AddRule(conditionString, new SingleActionSelector(actions[0]));
				}
				else
				{
					prod.AddRule(conditionString, null);
				}
				
			}
			return prod;
		}
		
	}
	
}