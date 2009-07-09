package org.evogen.entity
{

	public class Population
	{
		
		public function get Breedables():Vector.<Breedable>
		{
			return population;
		}
		
		public function get Fitnesses():Vector.<Number>
		{
			return fitnesses;
		}
		
		public function get Specimens():Vector.<Specimen>
		{
			var returnme : Vector.<Specimen> = new Vector.<Specimen>();
			population.forEach(function(bs:Breedable, i:int, v:Vector.<Breedable>):void
			{
				returnme.push(bs.BreedableSpecimen);
			});
			return returnme;
		}
		
		public function Population()
		{
			population = new Vector.<Breedable>();
		}
		
		public function AddBreedable(breedable:Breedable, fitness:Number=NaN):Population
		{
			if(population.indexOf(breedable) == -1)
			{
				population.push(breedable);
				if(fitness)
				{
					fitnesses[population.length-1] = fitness;
				}
			}
			else
			{
				throw new Error("You cannot add the same breedable twice");
			}
			return this;
		}
		
		public function IntegratePopulation(population:Population):Population
		{
			population.Breedables
			return this;
		}
		
		private var population : Vector.<Breedable>;
		private var fitnesses : Vector.<Number>;
	}
}