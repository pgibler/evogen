package org.evogen.breeder
{
	import org.evogen.entity.Specimen;
	import org.evogen.genetics.chromosome.Chromosome;
	
	public class TwoThirdsRatioBreeder implements Breeder
	{
		
		public function Breed(population:Vector.<Specimen>, evaluator:SpecimenEvaluator):Vector.<Chromosome>
		{
			var fitness : Function = evaluator.EvaluateFitness;
			population = population.sort(function(a:Specimen, b:Specimen):Number
			{
				return fitness(a) > fitness(b) ? -1 : 0;
			});
			var selectionProbability : Vector.<Number> = new Vector.<Number>();
			var returnme : Vector.<Chromosome> = new Vector.<Chromosome>();
			var hasHigherFitness : Boolean = true;
			var lastFitness : Number = -1;
			var numLeft : Number = 1;
			var ratio : Number = 2.0/3.0;
			var popSize : int = population.length;
			for(var i : int = 0; i < popSize; i++)
			{				
				if(lastFitness != -1)
				{
					hasHigherFitness = fitness(i) > fitness(i-1);
					if(!hasHigherFitness)
					{
						var splitRatio : Number = ratio / (population.length - i);
						for(var j : int = i; j < popSize; j++)
						{
							selectionProbability.push(splitRatio);
						}
						break;
					}
				} else {
					lastFitness = fitness(population[i]);
				}
				selectionProbability.push(numLeft/ratio);
				numLeft /= ratio;
			}
			
			returnme.concat(population.slice(0, popSize/2));
			
			for(var n : int = popSize/2 + 1; n < popSize; n++)
			{
				if(Math.random() < .5)
				{
					returnme.push(ChooseSpecimenForMutationAndMutate(population, selectionProbability, evaluator));
				}
				else
				{
					returnme.push(ChooseTwoSpecimensAndCrossover(population, selectionProbability, evaluator));
				}
			} 
			
			return returnme;
		}
		
		/**
		 * Crosses over two specimens and produces a child chromosome from them.
		 * @param	specimen1 The first specimen to cross over with.
		 * @param	specimen2 The second specimen to cross over with.
		 * @return	A child chromosome from the two specimens.
		 */
		private function Crossover(specimen1:Specimen, specimen2:Specimen):Chromosome
		{
			var crossoverPoint : int = int(Math.random() * specimen1.SpecimenChromosome.Traits.length);
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
			chromosome.Traits = chromosome.Traits.concat(topChrom.Traits.slice(0, crossoverPoint-1));
			chromosome.Traits = chromosome.Traits.concat(botChrom.Traits.slice(crossoverPoint, botChrom.Traits.length));
			return chromosome;
		}
		
		/**
		 * Chooses a specimen for crossover and returns the new chromosome.
		 * @param	population A population of specimens.
		 * @param	selectionProbabilities The probability to select a specimen.
		 * @param	evaluator The evaluation function for the specimens.
		 * @return	A crossed over chromosome.
		 */
		private function ChooseSpecimen(population:Vector.<Specimen>, selectionProbabilities:Vector.<Number>, evaluator:SpecimenEvaluator):Specimen
		{
			var randNum : Number = Math.random();
			var specimen : Specimen;
			for(var i : int = 0; i < population.length; i++)
			{
				if(selectionProbabilities[i] < randNum)
				{
					// Determine if there are other specimens with the same selection probability
					var sameProbs : Vector.<Specimen> = new Vector.<Specimen>();
					sameProbs.push(population[i]);
					for(var j : int = i; j < population.length; j++)
					{
						if(selectionProbabilities[j] == selectionProbabilities[i])
						{
							sameProbs.push(population[j]);
						}
						else
						{
							break;
						}
					}
					return sameProbs[Math.random()*sameProbs.length-1]
				}
			}
			throw new Error("This shouldn't have happened.");
		}
		
		/**
		 * Chooses a specimen mutation and returns the new chromosome.
		 * @param	population A population of specimens.
		 * @param	selectionProbabilities The probability to select a specimen.
		 * @param	evaluator The evaluation function for the specimens.
		 * @return	A mutated chromosome.
		 */
		private function ChooseSpecimenForMutationAndMutate(population:Vector.<Specimen>, selectionProbabilities:Vector.<Number>, evaluator:SpecimenEvaluator):Chromosome
		{
			return ChooseSpecimen(population, selectionProbabilities, evaluator).BreedableSpecimen.SpecimenChromosome.Mutate(.1);
		}
		
		/**
		 * Chooses two specimen from a population and crosses them over.
		 * @param	population A population of specimens.
		 * @param	selectionProbabilities The probability to select a specimen.
		 * @param	evaluator The evaluation function for the specimens.
		 * @return	A crossed over chromosome.
		 */
		private function ChooseTwoSpecimensAndCrossover(population:Vector.<Specimen>, selectionProbabilities:Vector.<Number>, evaluator:SpecimenEvaluator):Chromosome
		{
			var s1 : Specimen = ChooseSpecimen(population, selectionProbabilities, evaluator);
			var s1Index : int = population.indexOf(s1);
			population.splice(s1Index, 1);
			selectionProbabilities.splice(s1Index, 1);
			var s2 : Specimen = ChooseSpecimen(population, selectionProbabilities, evaluator);
			return Crossover(s1, s2);
		}
	}
}