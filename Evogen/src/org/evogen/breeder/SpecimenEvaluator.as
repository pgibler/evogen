package org.evogen.breeder
{
	import org.evogen.entity.Specimen;

	public interface SpecimenEvaluator
	{
		function EvaluateFitness(specimen:Specimen):Number;
	}
}