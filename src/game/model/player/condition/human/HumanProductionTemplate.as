package game.model.player.condition.human 
{
	import game.model.player.condition.Condition;
	import game.model.player.condition.LeftKeyDownCondition;
	import game.model.player.condition.Production;
	import game.model.player.condition.ProductionTemplate;
	import game.model.player.condition.RightKeyDownCondition;
	
	/**
	 * ...
	 * @author 
	 */
	public class HumanProductionTemplate extends ProductionTemplate
	{
		
		public function HumanProductionTemplate() 
		{
			conditions.push(new LeftKeyDownCondition());
			conditions.push(new RightKeyDownCondition());
		}
		
		override public function GenerateProduction():Production 
		{
			var prod : Production = new Production(conditions);
			return prod;
		}
		
		private var conditions : Vector.<Condition>;
		
	}
	
}