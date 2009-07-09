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
		
		public function AddBreedable(breedable:Breedable, fitness:Number):Population
		{
			if(breedables.indexOf(breedable) == -1)
			{
				breedables.push(breedable);
				fitnesses.push( fitness );
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
				var val : Number = n2 - n1;
				if(val > 0)
				{
					val = 1;
				}
				else if(val < 0)
				{
					val = -1;
				}
				else
				{
					val = 0;
				}
				return val;
			});
			var sortedBreedables : Vector.<Breedable> = new Vector.<Breedable>(breedables.length);
			breedables.forEach(function(spec:Specimen, index:int, v:Vector.<Breedable>):void
			{
				var fitness : Number = fitnesses[index];
				var i : int = sortedFitnesses.indexOf(fitness);
				for(var j : int = i; j < sortedFitnesses.length; j++)
				{
					if(fitness > sortedFitnesses[j])
					{
						throw new Error("This shouldn't happen");
					}
					if(sortedBreedables[j] == null)
					{
						sortedBreedables[j] = breedables[i];
						break;
					}
				}
			});
			this.breedables = sortedBreedables;
			return this;
		}
		
		public function IntegratePopulation(population:Population):Population
		{
			population.breedables.forEach(function(b:Breedable, i:int, v:Vector.<Breedable>):void
			{
				for(var j : int = 0; j < this.breedables.length; j++)
				{
					if(this.breedables[j].BreedableSpecimen.SpecimenChromosome.Equals(b.BreedableSpecimen.SpecimenChromosome)
					{
						this.breedables.splice(j, 1);
						this.fitnesses.splice(j, 1);
						break;
					}
				}
			});
			
			this.breedables = this.breedables.concat(population.breedables);
			this.fitnesses = this.fitnesses.concat(population.fitnesses);
			SortByFitness();
			return this;
		}
		
		public function Truncate(cutoffPoint:int):Population
		{
			breedables.splice(cutoffPoint, breedables.length-cutoffPoint);
			fitnesses.splice(cutoffPoint, fitnesses.length-cutoffPoint);
			return this;
		}
		
		private var breedables : Vector.<Breedable>;
		private var fitnesses : Vector.<Number>;
	}
}