package org.evogen.entity
{
	
	
	public class PopulationPool
	{
		
		public function get Populations():Vector.<Population>
		{
			return populations;
		}
		
		public function get TopPopulation():Population
		{
			return this.topPopulation;
		}
		
		public function PopulationPool(maxPopulations:int=5)
		{
			this.maxPopulations = maxPopulations
			this.populations = new Vector.<Population>();
			this.populationScores = new Vector.<Number>();
			this.topPopulation = new Population();
		}
		
		public function AddPopulation(population:Population, fitness:Number):PopulationPool
		{
			topPopulation;
			
			if(populations.length < maxPopulations)
			{
				populations.unshift(population);
				populationScores.unshift(fitness);
			}
			else
			{
				if(fitness >= populationScores[0])
				{
					populations.unshift(population);
					populationScores.unshift(fitness);
					
					populations.pop();
					populationScores.pop();
				}
				else if(fitness > populationScores[populationScores.length-1])
				{
					for(var i : int = populationScores.length-1; i >= 1; i--)
					{
						if(fitness <= populationScores[i-1] && fitness > populationScores[i])
						{
							populations.splice(i,0,population);
							populationScores.splice(i,0,fitness);
							populations.pop();
							populationScores.pop();
							break;
						}
					}
				}
			}
			return this;
		}
		
		private var maxPopulations : int;
		private var topPopulation : Population;
		private var populationScores : Vector.<Number>;
		private var populations : Vector.<Population>;
	}
}