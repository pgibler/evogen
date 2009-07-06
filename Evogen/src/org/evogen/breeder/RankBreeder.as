package org.evogen.breeder
{
	import org.evogen.entity.PopulationPool;
	import org.evogen.entity.Specimen;
	import org.evogen.genetics.chromosome.Chromosome;
	
	public class RankBreeder implements Breeder
	{
		
		public function RankBreeder(p:Number):void
		{
			if(p <= 0 || p >= 1)
			{
				throw new Error("p must be between 0 and 1");
			}
			this.p = p;
		}
		
		public function Breed(populationPool:PopulationPool, evaluator:SpecimenEvaluator):Vector.<Chromosome>
		{
			this.population = populationPool.TopPopulation.Specimens.slice();
			this.fitness = evaluator.EvaluateFitness;
			population = evaluator.SortSpecimens(population);
			var fitnesses : Vector.<Number> = new Vector.<Number>();
			population.forEach(function(spec:Specimen, index:int, pop:Vector.<Specimen>):void
			{
				fitnesses.push( fitness(spec) );
			});
			selectionProbabilities = new Vector.<Number>();
			var returnme : Vector.<Chromosome> = new Vector.<Chromosome>();
			var nextHasHigherFitness : Boolean = true;
			var lastFitness : Number = -1;
			var numLeft : Number = 1;
			var ratio : Number = p;
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
							var splitRatio : Number = numLeft / (population.length - i);
							for(var j : int = i; j < popSize; j++)
							{
								selectionProbabilities.push(splitRatio);
								populationOfLowestNumber.push(population[j]);
							}
							break;
						}
					} else {
						populationMinusLowestNumber.push(population[i]);
						lastFitness = fitness(population[i]);
					}
				} else {
					populationMinusLowestNumber.push(population[i]);
					lastFitness = fitness(population[i]);
				}
				selectionProbabilities.push(numLeft*ratio);
				numLeft -= numLeft*ratio;
			}
			
			var topPercentile : int = popSize/2;
			
			population.slice(0, topPercentile).forEach(function(spec:Specimen, index:int, pop:Vector.<Specimen>):void
			{
				returnme.push( spec.BreedableSpecimen.SpecimenChromosome );
			});
			
			for(var n : int = topPercentile; n < popSize; n++)
			{
				if(Math.random() < .5)
				{
					returnme.push(ChooseSpecimenForMutationAndMutate());
				}
				else
				{
					returnme.push(ChooseTwoSpecimensAndCrossover());					
				}
			} 
			
			return returnme;
		}
		
		/**
		 * Chooses a specimen for crossover and returns the new chromosome.
		 * @return	A crossed over chromosome.
		 */
		private function ChooseSpecimen(population:Vector.<Specimen> = null, selectionProbabilities : Vector.<Number> = null):Specimen
		{
			population = population == null ? this.population : population;
			selectionProbabilities = selectionProbabilities == null ? this.selectionProbabilities : selectionProbabilities;
			
			var randNum : Number = .3//Math.random();
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
				var indx : int = Math.round(Math.random()*(populationOfLowestNumber.length-1));
				return populationOfLowestNumber[indx];
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
					return sameProbs[Math.round(Math.random()*(sameProbs.length-1))];
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
			return BreederHelper.Mutate(ChooseSpecimen(), .1);
		}
		
		/**
		 * Chooses two specimen from a population and crosses them over.
		 * @return	A crossed over chromosome.
		 */
		private function ChooseTwoSpecimensAndCrossover():Chromosome
		{
			var s1 : Specimen = ChooseSpecimen();
			var s1Index : int = population.indexOf(s1);
			var myPop : Vector.<Specimen> = population.slice();
			myPop.splice(s1Index, 1)
			var mySelectProb : Vector.<Number> = selectionProbabilities.slice();
			var prob : Number = mySelectProb.splice(s1Index, 1)[0];
			prob /= mySelectProb.length;
			for(var i : int = 0 ; i < mySelectProb.length; i++)
			{
				mySelectProb[i] += prob;
			}
			var s2 : Specimen = ChooseSpecimen(myPop, mySelectProb);
			return BreederHelper.Crossover(s1, s2);
		}
		
		private var populationMinusLowestNumber : Vector.<Specimen>;
		private var populationOfLowestNumber : Vector.<Specimen>;
		private var population : Vector.<Specimen>;
		private var selectionProbabilities : Vector.<Number>;
		private var fitness : Function;
		private var p : Number;
	}
}