package game.model.player.computer 
{
	import flash.display.ActionScriptVersion;
	import flash.utils.getQualifiedClassName;
	import game.model.player.action.Action;
	import game.util.MathUtil;
	import org.evogen.genetics.chromosome.Chromosome;
	import org.evogen.genetics.chromosome.ChromosomeTemplate;
	import org.evogen.genetics.trait.BinaryTraitTemplate;
	import org.evogen.genetics.trait.ProbabilisticTrait;
	import org.evogen.genetics.trait.ProbabilisticTraitTemplate;
	import org.evogen.genetics.trait.Trait;
	
	/**
	 * ...
	 * @author pgibler
	 */
	public class ProductionTemplate
	{
		
		public function ProductionTemplate() 
		{
			var conditions : Vector.<Condition> = new Vector.<Condition>();
			conditions.push(new IsInMeleeRange());
			conditions.push(new IsOnGroundCondition());
			conditions.push(new OpponentIsAttacking());
			conditions.push(new OpponentIsOnGroundCondition());
			
			chromosomeTemplate = new ChromosomeTemplate();
			var numberOfConditions : int = Math.pow(2, conditions.length);
			var conditionString : String;
			var tt : ProbabilisticTraitTemplate;
			for (var i : int = 0; i < numberOfConditions; i++)
			{
				conditionString = MathUtil.ConvertDecimalIntegerToBinaryString(i);
				tt = new ProbabilisticTraitTemplate(conditionString);
				for each(var clazz : Class in GetIntersectionOfActions(conditionString)
				{
					tt.AddState(getQualifiedClassName(clazz));
				}
				chromosomeTemplate.AddTraitTemplate(tt);
			}
		}
		
		public function GenerateRandomizedProduction():Production
		{
			var p : Production = new Production();
			var c : Chromosome = chromosomeTemplate.GenerateRandomChromosome();
			var actions : Vector.<Class>;
			for each(var t : ProbabilisticTrait in c.Traits)
			{
				var probs : Vector.<Number> = t.StateProbabilities;
				var conditionString : String = t.Name;
				var apm : ActionProbabilityMap = new ActionProbabilityMap(GetIntersectionOfActions(conditionString), probs);
				p.AddConditionState(apm);
			}
			return p;
			
		}
		
		public function GenerateProductionFromDNA(dna:String):Production
		{
			var p : Production = new Production();
			var ct : ChromosomeTemplate = 
		}
		
		private function GetValidActions(condition:Condition, state:Boolean):Vector.<Class>
		{
			return (state) ? condition.PossibleActionsWhenTrue : condition.PossibleActionsWhenFalse;
		}
		
		private function GetIntersectionOfActions(conditionString : String):Vector.<Class>
		{
			var actionVectors : Vector.<Class> = new Vector.<Class>();
			
			for (var j : int = 0; j < conditionString.length; j++)
			{
				var validity : Boolean = conditionString.charAt(j) == "1";
				var conditionActions : Vector.<Class> = (validity) ? conditions[j].PossibleActionsWhenTrue : conditions[j].PossibleActionsWhenFalse;
				actions.push(conditionActions);
			}
			
			var actions : Vector.<Class> = actionVectors[0];
			
			for (var i : int = 1; i < actionVectors.length; i++)
			{
				actions.filter(function(item:*, index:int, array:Array) {
					return array.indexOf(item) != -1;
				});
			}
			return actions;
		}
		
		private var chromosomeTemplate : ChromosomeTemplate;
		private var conditions : Vector.<Condition>;
		
		private var conditionStrings : Vector.<String>;
		private var actionProbabilityMaps : Vector.<ActionProbabilityMap>;
		
	}
	
}