package org.evogen.breeder
{
	import org.evogen.entity.Specimen;
	import org.evogen.genetics.chromosome.Chromosome;
	
	public class StandardBreeder implements Breeder
	{
		
		private var populationCache : Vector.<Specimen>;
		
		public function Crossover(specimen1:Specimen, specimen2:Specimen):Chromosome
		{
			var crossoverPoint : int = int(Math.random() * specimen1.SpecimenChromosome.Traits.length);
			
		}
		
		public function Mutate(chromosome:Chromosome):Chromosome
		{
			return chromosome.Mutate(.1);
		}
		
		public function ChooseSpecimenForBreeding(population:Vector.<Specimen>, evaluator:SpecimenEvaluator):Specimen
		{
			if(populationCache !== population)
			{
				populationCache = population;
				
				var fitness : Function = evaluator.EvaluateFitness;
				populationCache.sort(function(a:Specimen, b:Specimen):int
				{
					return fitness(a) == 0 ? 0 : ((b) - fitness(a))/Math.abs(fitness(b)/fitness(a));
				});
			}
			return populationCache;
		}
	}
}