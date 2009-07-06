package org.evogen.entity
{

	public class Population
	{
		
		public function get Breedables():Vector.<Breedable>
		{
			return population;
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
		
		public function AddBreedable(breedable:Breedable):Population
		{
			population.push(breedable);
			return this;
		}
		
		private var population : Vector.<Breedable>;
	}
}