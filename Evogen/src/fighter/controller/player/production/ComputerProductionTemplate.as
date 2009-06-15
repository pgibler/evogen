package fighter.controller.player.production
{
	import fighter.controller.player.action.Action;
	import fighter.controller.player.condition.*;
	import fighter.util.MathUtil;
	
	import org.evogen.genetics.chromosome.Chromosome;
	import org.evogen.genetics.chromosome.ChromosomeTemplate;
	import org.evogen.genetics.trait.ProbabilisticTrait;
	import org.evogen.genetics.trait.ProbabilisticTraitTemplate;
	
	/**
	 * ...
	 * @author pgibler
	 */
	public class ComputerProductionTemplate extends ProductionTemplate
	{
		
		public function ComputerProductionTemplate() 
		{
			super(Vector.<Condition>([	new IsInMeleeRange(),
										new IsOnGroundCondition(),
										new OpponentIsAttacking(),
										new OpponentIsOnGroundCondition()]));
			
			chromosomeTemplate = new ChromosomeTemplate();
			
			var conditionString : String;
			var tt : ProbabilisticTraitTemplate;
			var conditionCombinations : Number = ConditionCombinations;
			for (var i : int = 0; i < conditionCombinations; i++)
			{
				conditionString = MathUtil.ConvertBaseTenIntegerToBinaryString(i, Conditions.length-1);
				tt = new ProbabilisticTraitTemplate(conditionString);
				var actions : Vector.<Action> = GetIntersectionOfActions(conditionString);
				var action : Action;
				for each(action in  actions)
				{
					tt.AddState(action.Name);
				}
				chromosomeTemplate.AddTraitTemplate(tt);
			}
		}
		
		override public function GenerateProduction():Production
		{
			var p : Production = new Production(this);
			var c : Chromosome = chromosomeTemplate.GenerateRandomChromosome();
			var actions : Vector.<Class>;
			for each(var t : ProbabilisticTrait in c.Traits)
			{
				var probs : Vector.<Number> = t.StateProbabilities;
				var conditionString : String = t.Name;
				var apm : ActionSelector = new ProbabilisticActionSelector(GetIntersectionOfActions(conditionString), probs);
				p.AddRule(conditionString, apm);
			}
			return p;
			
		}
		
		public function GenerateProductionFromDNA(dna:String):Production
		{
			var p : Production = new Production(this);
			return p;
		}
		
		private var chromosomeTemplate : ChromosomeTemplate;
		
	}
	
}