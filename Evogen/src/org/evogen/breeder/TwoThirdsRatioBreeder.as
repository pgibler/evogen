package org.evogen.breeder
{
	import org.evogen.entity.Specimen;
	import org.evogen.genetics.chromosome.Chromosome;
	
	public class TwoThirdsRatioBreeder implements Breeder
	{
		
		public function Breed(population:Vector.<Specimen>, evaluator:SpecimenEvaluator):Vector.<Chromosome>
		{
			this.population = population;
			this.fitness = evaluator.EvaluateFitness;
			population = population.sort(function(a:Specimen, b:Specimen):Number
			{
				if(fitness(a) > fitness(b))
				{
					return -1;
				}
				else if(fitness(a) < fitness(b))
				{
					return 1;
				}
				return 0;
			});
			var fitnesses : Vector.<Number> = new Vector.<Number>();
			population.forEach(function(spec:Specimen, index:int, pop:Vector.<Specimen>):void
			{
				fitnesses.push( fitness(spec) );
			});
			var selectionProbability : Vector.<Number> = new Vector.<Number>();
			var returnme : Vector.<Chromosome> = new Vector.<Chromosome>();
			var nextHasHigherFitness : Boolean = true;
			var lastFitness : Number = -1;
			var numLeft : Number = 1;
			var ratio : Number = 2.0/3.0;
			var popSize : int = population.length;
			populationMinusLowestNumber = new Vector.<Specimen>();
			populationOfLowestNumber = new Vector.<Specimen>();
			for(var i : int = 0; i < popSize; i++)
			{				
				if(lastFitness != -1)
				{
					if(i+1 < fitnesses.length)
					{
						nextHasHigherFitness = fitnesses[i+1] > fitnesses[i];
						if(!nextHasHigherFitness)
						{
							var splitRatio : Number = ratio / (population.length - i);
							for(var j : int = i; j < popSize; j++)
							{
								selectionProbability.push(splitRatio);
								populationOfLowestNumber.push(population[j]);
							}
							break;
						}
					}
				} else {
					populationMinusLowestNumber.push(population[i]);
					lastFitness = fitness(population[i]);
				}
				selectionProbability.push(numLeft*ratio);
				numLeft -= numLeft*ratio;
			}
			
			population.slice(0, popSize/2).forEach(function(spec:Specimen, index:int, pop:Vector.<Specimen>):void
			{
				returnme.push( spec.BreedableSpecimen.SpecimenChromosome );
			});
			
			for(var n : int = popSize/2 + 1; n < popSize; n++)
			{
				/*if(Math.random() < .5)
				{
					returnme.push(ChooseSpecimenForMutationAndMutate(population, selectionProbability, evaluator));
				}
				else
				{
					returnme.push(ChooseTwoSpecimensAndCrossover(population, selectionProbability, evaluator));
				}*/
				returnme.push(ChooseSpecimenForMutationAndMutate());
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
		 * @return	A crossed over chromosome.
		 */
		private function ChooseSpecimen():Specimen
		{
			var randNum : Number = Math.random();
			var total : Number = 0;
			var specimen : Specimen;
			
			var totalOfLowest : Number = 0;
			var i : int;
			for(i = population.length-populationOfLowestNumber.length; i < population.length; i++)
			{
				totalOfLowest += selectionProbabilities[i];
			}
			
			if(randNum < totalOfLowest)
			{
				return populationOfLowestNumber[Math.round(Math.random()*populationOfLowestNumber.length-1)];
			}
			
			for(i = populationMinusLowestNumber.length-1; i > 0; i--)
			{
				total += selectionProbabilities[i];
				if(total >= randNum)
				{
					// Determine if there are other specimens with the same selection probability
					var sameProbs : Vector.<Specimen> = new Vector.<Specimen>();
					sameProbs.push(population[i]);
					for(var j : int = 0; j < population.length; j++)
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
					return sameProbs[Math.round(Math.random()*sameProbs.length-1)]
				}
			}
			throw new Error("This shouldn't have happened.");
		}
		
		/**
		 * Chooses a specimen mutation and returns the new chromosome.
		 * @return	A mutated chromosome.
		 */
		private function ChooseSpecimenForMutationAndMutate():Chromosome
		{
			return ChooseSpecimen().BreedableSpecimen.SpecimenChromosome.Mutate(.1);
		}
		
		/**
		 * Chooses two specimen from a population and crosses them over.
		 * @return	A crossed over chromosome.
		 */
		private function ChooseTwoSpecimensAndCrossover():Chromosome
		{
			var s1 : Specimen = ChooseSpecimen();
			var s1Index : int = population.indexOf(s1);
			population.splice(s1Index, 1);
			selectionProbabilities.splice(s1Index, 1);
			var s2 : Specimen = ChooseSpecimen();
			return Crossover(s1, s2);
		}
		
		private var populationMinusLowestNumber : Vector.<Specimen>;
		private var populationOfLowestNumber : Vector.<Specimen>;
		private var population : Vector.<Specimen>;
		private var selectionProbabilities : Vector.<Number>;
		private var fitness : Function;
	}
}