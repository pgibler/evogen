package org.evogen.breeder
{
	import org.evogen.entity.Specimen;
	import org.evogen.genetics.chromosome.Chromosome;
	

	public interface Breeder
	{
		/**
		 * Breeds a new set of chromosomes from the specimen population.
		 * @param	breedablePopulation The population of specimens from which a child generation of chromosomes will be formed.
		 * @param	evaluator The fitness function to determine the most fit specimens.
		 * @return	The set of bred chromosomes as determined by the fitness function.
		 */
		function Breed(population:Vector.<Specimen>, evaluator:SpecimenEvaluator):Vector.<Chromosome>;
	}
}