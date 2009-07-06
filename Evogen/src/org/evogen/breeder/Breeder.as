package org.evogen.breeder
{
	import org.evogen.entity.PopulationPool;
	import org.evogen.genetics.chromosome.Chromosome;
	

	public interface Breeder
	{
		/**
		 * Breeds a new set of chromosomes from the specimen population.
		 * @param	populationPool A pool of several different populations of specimens from which a child generation of chromosomes will be formed. The pool will not be modified.
		 * @param	evaluator The fitness function to determine the most fit specimens.
		 * @return	The set of bred chromosomes as determined by the fitness function.
		 */
		function Breed(populationPool:PopulationPool, evaluator:SpecimenEvaluator):Vector.<Chromosome>;
	}
}