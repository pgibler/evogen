package org.evogen.breeder
{
	import org.evogen.entity.Specimen;
	import org.evogen.genetics.chromosome.Chromosome;

	public class BreederHelper
	{
		
		/**
		 * Crosses over two specimens and produces a child chromosome from them.
		 * @param	specimen1 The first specimen to cross over with.
		 * @param	specimen2 The second specimen to cross over with.
		 * @return	A child chromosome from the two specimens.
		 */
		public static function Crossover(specimen1:Specimen, specimen2:Specimen):Chromosome
		{
			var crossoverPoint : int = int(Math.random() * (specimen1.SpecimenChromosome.Traits.length-1));
			var chromosome : Chromosome = new Chromosome(specimen1.BreedableSpecimen.SpecimenChromosome.Template);
			chromosome.TraitNames = specimen1.SpecimenChromosome.TraitNames.slice();
			var topChrom : Chromosome;
			var botChrom : Chromosome;
			if(Math.random() < .5)
			{
				topChrom = specimen1.BreedableSpecimen.SpecimenChromosome;
				botChrom = specimen2.BreedableSpecimen.SpecimenChromosome;
			}
			else
			{
				topChrom = specimen2.BreedableSpecimen.SpecimenChromosome;
				botChrom = specimen1.BreedableSpecimen.SpecimenChromosome;
			}
			chromosome.Traits = chromosome.Traits.concat(topChrom.Traits.slice(0, crossoverPoint));
			chromosome.Traits = chromosome.Traits.concat(botChrom.Traits.slice(crossoverPoint));
			return chromosome;
		}
		
		public static function Mutate(specimen:Specimen, mutationPercent:Number):Chromosome
		{
			return specimen.SpecimenChromosome.Mutate(mutationPercent);
		}
	}
}