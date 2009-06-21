package org.evogen.breeder
{
	import org.evogen.entity.Specimen;

	public interface SpecimenEvaluator
	{
		/**
		 * Evaluates the fitness of a specimen.
		 * @param	specimen A specimen to evaluate
		 * @return	The fitness of the specimen.
		 */
		function EvaluateFitness(specimen:Specimen):Number;
		/**
		 * Sorts specimens from most fit (0) to least fit (specimens.length). Returns the sorted specimen list. Does not modify the original list.
		 * @param	specimens A list of specimens to be sorted according to fitness.
		 * @return	A sorted specimen list.
		 */
		function SortSpecimens(specimens:Vector.<Specimen>):Vector.<Specimen>;
	}
}