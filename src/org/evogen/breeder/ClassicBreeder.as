package org.evogen.breeder
{
	import org.evogen.entity.PopulationPool;
	import org.evogen.genetics.chromosome.Chromosome;
	
	public class ClassicBreeder implements Breeder
	{
		public function ClassicBreeder()
		{
		}
		
		public function Breed(populationPool:PopulationPool, evaluator:SpecimenEvaluator):Vector.<Chromosome>
		{
			var population : Vector.<Specimen> = populationPool.TopPopulation;
			
			var chromosomes : Vector.<Chromosome> = new Vector.<Chromosome>(); 
			population.
			return null;
		}
	}
}