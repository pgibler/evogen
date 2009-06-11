package game.model.player.condition.computer
{
	import flash.utils.getQualifiedClassName;
	import game.model.player.action.Action;
	import game.model.player.condition.ProductionTemplate;
	import game.util.MathUtil;
	import org.evogen.genetics.chromosome.Chromosome;
	import org.evogen.genetics.chromosome.ChromosomeTemplate;
	import org.evogen.genetics.trait.BinaryTraitTemplate;
	import org.evogen.genetics.trait.ProbabilisticTrait;
	import org.evogen.genetics.trait.ProbabilisticTraitTemplate;
	import org.evogen.genetics.trait.Trait;
	import game.model.player.condition.*;
	
	/**
	 * ...
	 * @author pgibler
	 */
	public class ComputerProductionTemplate extends ProductionTemplate
	{
		
		public function ComputerProductionTemplate() 
		{
			super();
			Conditions.push(new IsInMeleeRange());
			Conditions.push(new IsOnGroundCondition());
			Conditions.push(new OpponentIsAttacking());
			Conditions.push(new OpponentIsOnGroundCondition());
			
			chromosomeTemplate = new ChromosomeTemplate();
			var numberOfConditions : int = Math.pow(2, Conditions.length);
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
		
		override public function GenerateProduction():Production
		{
			var p : Production = new Production(conditions);
			var c : Chromosome = chromosomeTemplate.GenerateRandomChromosome();
			var actions : Vector.<Class>;
			for each(var t : ProbabilisticTrait in c.Traits)
			{
				var probs : Vector.<Number> = t.StateProbabilities;
				var conditionString : String = t.Name;
				var apm : ActionProbabilityMap = new ActionProbabilityMap(GetIntersectionOfActions(conditionString), probs);
				p.AddRule(conditionString, apm);
			}
			return p;
			
		}
		
		public function GenerateProductionFromDNA(dna:String):Production
		{
			var p : Production = new Production();
		}
		
	}
	
}