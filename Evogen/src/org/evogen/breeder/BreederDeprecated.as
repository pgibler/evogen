package org.evogen.breeder
{
	import org.evogen.genetics.chromosome.Chromosome;
	import org.evogen.genetics.trait.Trait;
	import org.evogen.entity.Specimen;
	import org.evogen.entity.Breedable;
	
	/**
	 * The <code>Breeder</code> picks and chooses chromosomes from a population and breeds them together
	 * to create a new population of chromosomes.
	 * @author Paul Gibler
	 */
	public interface BreederDeprecated 
	{
		public static const ALL_CHROMOSOMES : int = -1;
		
		/**
		 * The fitness function used to evaluate specimens in the current population.
		 */
		public function get Fitness() : SpecimenEvaluator;
		public function get 
		
		/**
		 * Creates an instance of Breeder.
		 * @param	fitness The fitness function used to calculate the most fit. It must take a Specimen as a parameter and return a Number as the result.
		 * @param	topPercentile
		 * @param	breedingDistribution
		 * @param	mutationProbability
		 */
		public function BreederDeprecated(fitness:Function, breed:Function, topPercentile:Number=1/4, breedingDistribution:Number=1, mutationProbability:Number=.1) 
		{
			this.Fitness = fitness;
			this.TopPercentile = topPercentile;
			this.BreedingDistribution = breedingDistribution;
		}
		
		/**
		 * Breeds a new set of chromosomes from the specimen population.
		 * @param	breedablePopulation The population of specimens from which a child generation of chromosomes will be formed.
		 * @return	The set of bred chromosomes as determined by the fitness function.
		 */
		public function breed(breedablePopulation:Vector.<Breedable>, chromosomesReturned:int = ALL_CHROMOSOMES):Vector.<Chromosome>
		{
			var population : Vector.<Specimen> = breedablePopulation.map(function(breedable:Breedable, index:int, vec:Vector.<Breedable>):Specimen
			{
				return breedable.BreedableSpecimen;
			});
			// Sorts Specimens by which are most fit according to the fitness function
			population.sort(function(a:Specimen, b:Specimen):int
			{
				return Fitness(a) == 0 ? 0 : (Fitness(b) - Fitness(a))/Math.abs(Fitness(b)/Fitness(a));
			});
			
			var topIndex : int = Math.ceil(population.length * TopPercentile);
			var topSpecimens : Vector.<Specimen> = population.splice(0, topIndex);
			
			// Breed the top specimens together, based on the breeding distribution.
			var breedingDistance : int = Math.round(topIndex * BreedingDistribution);
			
			var chromosomes : Vector.<Chromosome> = new Vector.<Chromosome>();
			var c : Chromosome;
			for (var i : int = 0; i < topSpecimens.length-1; i++)
			{
				for (var j : int = 1; j < breedingDistance; j++)
				{
					chromosomes.push(breedChromosomes(topSpecimens[i + j].SpecimenChromosome, topSpecimens[i + j + 1].SpecimenChromosome));
				}
			}
			
			return chromosomes;
		}
		
		private function breedChromosomes(c1:Chromosome, c2:Chromosome):Chromosome
		{
			var newTraits : Vector.<Trait> = new Vector.<Trait>();
			var returnme : Chromosome = new Chromosome(c1.Template);
			var breedPoint : int = Math.round(Math.random() * c1.Traits.length);
			var i : int = 0;
			var chromosome1 : Chromosome;
			var chromosome2 : Chromosome;
			var decision : int = Math.round(Math.random());
			if (decision == 1)
			{
				chromosome1 = c1;
				chromosome2 = c2;
			}
			else
			{
				chromosome1 = c2;
				chromosome2 = c1;
			}
			for (i = 0; i < breedPoint; i++)
			{
				newTraits.push(chromosome1.Traits[i]);
			}
			
			for (i = 0; i < c1.Traits.length; i++)
			{
				newTraits.push(chromosome2.Traits[i]);
			}
			
			returnme.Traits = newTraits;
			returnme.TraitNames = chromosome1.TraitNames;
			return returnme;
		}
		
	}
	
}