package org.evogen.entity
{
	
	
	

	public class Population
	{
		
		public function get Breedables():Vector.<Breedable>
		{
			return breedables;
		}
		
		public function get Fitnesses():Vector.<Number>
		{
			return fitnesses;
		}
		
		public function get Specimens():Vector.<Specimen>
		{
			var returnme : Vector.<Specimen> = new Vector.<Specimen>();
			breedables.forEach(function(bs:Breedable, i:int, v:Vector.<Breedable>):void
			{
				returnme.push(bs.BreedableSpecimen);
			});
			return returnme;
		}
		
		public function Population()
		{
			breedables = new Vector.<Breedable>();
			fitnesses = new Vector.<Number>();
		}
		
		public function AddBreedable(breedable:Breedable, fitness:Number=NaN):Population
		{
			if(breedables.indexOf(breedable) == -1)
			{
				breedables.push(breedable);
				if(fitness)
				{
					fitnesses[breedables.length-1] = fitness;
				}
			}
			else
			{
				throw new Error("You cannot add the same breedable twice");
			}
			return this;
		}
		
		public function SortByFitness():Population
		{
			var sortedFitnesses : Vector.<Number> = fitnesses.sort(function(n1:Number, n2:Number):Number
			{
				return n1 - n2;
			});
			var sortedBreedables : Vector.<Breedable> = new Vector.<Breedable>(breedables.length);
			breedables.forEach(function(spec:Specimen, index:int, v:Vector.<Breedable>):void
			{
				var fitness : Number = fitnesses[index];
				var i : int = sortedFitnesses.indexOf(fitness);
				for(var j : int = i; j < sortedFitnesses.length; j++)
				{
					if(fitness != sortedFitnesses[j])
					{
						throw new Error("We've moved too far back in the list");
					}
					else if(sortedBreedables[j] == null)
					{
						sortedBreedables[j] = breedables[i];
					}
				}
			});
			this.breedables = sortedBreedables;
			return this;
		}
		
		public function IntegratePopulation(population:Population):Population
		{
			this.breedables.concat(population.Breedables);
			this.fitnesses.concat(population.Fitnesses);
			return this;
		}
		
		public function Truncate(cutoffPoint:int):Population
		{
			breedables.splice(cutoffPoint, breedables.length);
			fitnesses.splice(cutoffPoint, fitnesses.length);
			return this;
		}
		
		private var breedables : Vector.<Breedable>;
		private var fitnesses : Vector.<Number>;
	}
}