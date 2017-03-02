package org.evogen.breeder
{
	import org.evogen.specimen.PopulationPool;
	import org.evogen.specimen.Specimen;
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
			var returnme : Vector.<Chromosome> = new Vector.<Chromosome>();
			var fitnesses : Vector.<Number> = new Vector.<Number>();
			this.population = populationPool.TopPopulation.Specimens.slice();
			population = evaluator.SortSpecimens(population);
			this.fitness = evaluator.EvaluateFitness;
			population.forEach(function(spec:Specimen, index:int, pop:Vector.<Specimen>):void
			{
				fitnesses.push( fitness(spec) );
			});
			this.selectionProbabilities = new Vector.<Number>();
			var numLeft : Number = 1;
			var ratio : Number = this.p;
			selectionProbabilities.push(numLeft*ratio);
			numLeft -= numLeft*ratio;
			this.populationRanks = new Vector.<Vector.<Specimen>>();
			this.populationRanks.push(new Vector.<Specimen>);
			var currentFitness : Number = fitnesses[0];
			var currentRankIndex : Number = 0;
			this.population.forEach(function(spec:Specimen, i:int, v:Vector.<Specimen>):void
			{
				// Error checking
				if(fitnesses[i] > currentFitness)
				{
					throw new Error("This shouldn't happen");
				}
				
				if(fitnesses[i] < currentFitness)
				{
					populationRanks.push(new Vector.<Specimen>);
					selectionProbabilities.push(numLeft*ratio);
					numLeft -= numLeft*ratio;
					currentFitness = fitnesses[i];
				}
				populationRanks[populationRanks.length-1].push(spec);
			});
			
			var popSize : int = this.population.length;
			var topPercentile : int = popSize/2;
			
			population.slice(0, topPercentile).forEach(function(spec:Specimen, index:int, pop:Vector.<Specimen>):void
			{
				returnme.push( spec.BreedableSpecimen.SpecimenChromosome );
			});
			
			for(var n : int = topPercentile; n < popSize; n++)
			{
				returnme.push(ChooseSpecimenForMutationAndMutate());
				/*if(Math.random() < .5)
				{
					returnme.push(ChooseSpecimenForMutationAndMutate());
				}
				else
				{
					returnme.push(ChooseTwoSpecimensAndCrossover());
				}*/
			}
			
			return returnme;
		}
		
		/*public function Breed(populationPool:PopulationPool, evaluator:SpecimenEvaluator):Vector.<Chromosome>
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
		}*/
		
		/**
		 * Chooses a specimen for crossover and returns the new chromosome.
		 * @return	A crossed over chromosome.
		 */
		private function ChooseSpecimen(population:Vector.<Specimen> = null, selectionProbabilities : Vector.<Number> = null):Specimen
		{
			population = population == null ? this.population : population;
			selectionProbabilities = selectionProbabilities == null ? this.selectionProbabilities : selectionProbabilities;
			
			var i : int;
			var specimen : Specimen;
			
			var myPopRanks : Vector.<Vector.<Specimen>> = new Vector.<Vector.<Specimen>>();
			for(i = 0; i < this.populationRanks.length; i++)
			{
				myPopRanks.push(new Vector.<Specimen>());
			}
			
			for each(specimen in population)
			{
				for(i = 0; i < this.populationRanks.length; i++)
				{
					if(this.populationRanks[i].indexOf(specimen) != -1)
					{
						myPopRanks[i].push(specimen);
					}
				}
			}
			
			var randNum : Number = Math.random();
			var total : Number = 0;
			
			for(i = populationRanks.length-1; i >= 0; i--)
			{
				total += selectionProbabilities[i];
				if(total >= randNum || i == 0)
				{
					// Determine if there are other specimens with the same selection probability
					var specimensForChoosing : Vector.<Specimen> = populationRanks[i];
					if(specimensForChoosing.length <= 0)
					{
						specimensForChoosing = (i-1 > 0) ? populationRanks[i-1] : populationRanks[i+1];
					}
					specimen = specimensForChoosing[Math.round(Math.random()*(specimensForChoosing.length-1))];
					return specimen;
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
			var myPop : Vector.<Specimen> = this.population.slice();
			myPop.splice(s1Index, 1)
			var s2 : Specimen = ChooseSpecimen(myPop);
			return BreederHelper.Crossover(s1, s2);
		}
		
		private var selectionProbabilities : Vector.<Number>;
		private var populationRanks : Vector.<Vector.<Specimen>>;
		private var population : Vector.<Specimen>;
		private var fitness : Function;
		private var p : Number;
	}
}