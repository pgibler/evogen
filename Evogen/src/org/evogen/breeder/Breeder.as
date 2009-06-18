package org.evogen.breeder
{
	import org.evogen.entity.Specimen;
	import org.evogen.genetics.chromosome.Chromosome;

	public interface Breeder
	{
		/**
		 * Crosses over two specimens and produces a child chromosome from them.
		 * @param	specimen1 The first specimen to cross over with.
		 * @param	specimen2 The second specimen to cross over with.
		 * @return	A child chromosome from the two specimens.
		 */
		function Crossover(specimen1:Specimen, specimen2:Specimen):Chromosome;
		/**
		 * Generates and returns a mutated version of a chromosome, without modifying it.
		 * @param	chromosome The chromosome to mutate.
		 * @return	The mutated chromosome.
		 */
		function Mutate(chromosome:Chromosome):Chromosome;
		/**
		 * Chooses a specimen from a population to breed with.
		 * @param	population A population of specimens.
		 * @param	evaluator The evaluation function for the specimens.
		 * @return	A specimen to be used for breeding.
		 */
		function ChooseSpecimenForBreeding(population:Vector.<Specimen>, evaluator:SpecimenEvaluator):Specimen;
	}
}