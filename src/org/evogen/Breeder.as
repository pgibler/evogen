package org.evogen 
{
	
	/**
	 * The <code>Breeder</code> picks and chooses chromosomes from a population and breeds them together
	 * to create a new population of chromosomes.
	 * @author Paul Gibler
	 */
	public class Breeder 
	{
		public static const ALL_CHROMOSOMES : int = -1;
		
		/**
		 * The fitness function used to generate the child population.
		 */
		public var Fitness : Function;
		/**
		 * The top percentile of specimens. These will be bred into the next generation.
		 */
		public var TopPercentile : Number;
		/**
		 * Breeding distributions determine the range at which breeding will occur. A breeding distribution of 1 will cause uniform
		 * breeding amongst all specimens in the population. A breeding distribution of 0 means only adjacent specimens will be
		 * bred together.
		 */
		public var BreedingDistribution : Number;
		/**
		 * Determines the probability that a trait will be mutated upon crossover. A value of 1 will cause all traits to be mutated,
		 * whereas a value of 0 will cause no traits to be mutated.
		 */
		public var MutationProbability : Number;
		
		/**
		 * Creates an instance of Breeder.
		 * @param	fitness The fitness function used to calculate the most fit. It must take a Specimen as a parameter and return a Number as the result.
		 * @param	topPercentile
		 * @param	breedingDistribution
		 * @param	mutationProbability
		 */
		public function Breeder(fitness:Function, topPercentile:Number=1/4, breedingDistribution:Number=1, mutationProbability:Number=.1) 
		{
			this.Fitness = fitness;
			this.TopPercentile = topPercentile;
			this.BreedingDistribution = breedingDistribution;
		}
		
		/**
		 * Breeds a new set of chromosomes from the specimen population.
		 * @param	population The population of specimens from which a child generation of chromosomes will be formed.
		 * @return	The set of bred chromosomes as determined by the fitness function.
		 */
		public function breed(population:Vector.<Specimen>, chromosomesReturned:int = ALL_CHROMOSOMES):Vector.<Chromosome>
		{
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
			
			returnme.traits = newTraits;
			returnme.traitNames = chromosome1.TraitNames;
			return returnme;
		}
		
	}
	
}