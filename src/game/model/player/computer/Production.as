package game.model.player.computer 
{
	import game.model.player.action.Action;
	import game.util.MathUtil;
	
	/**
	 * ...
	 * @author pgibler
	 */
	public class Production 
	{
		
		public function Production()
		{
			
		}
		
		public function AddConditionState(actionProbabilityMap:ActionProbabilityMap):Production
		{
			actionProbabilityMaps.AddActionProbability(actionProbabilityMap);
			return this;
		}
		
		public function GetActionProbabilityMap(conditionState:String):ActionProbabilityMap
		{
			return actionProbabilityMaps[MathUtil.ConvertBinaryStringToDecimalInteger(conditionState)];
		}
		
		private var actionProbabilityMaps : Vector.<ActionProbabilityMap>;
		
	}
	
}