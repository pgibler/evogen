package fighter.model.breeder
{
	public class BreederSettings
	{
		public function get Generations():int
		{
			return generations;
		}
		
		public function get PopulationSize():int
		{
			return populationSize;
		}
		
		public function BreederSettings(generations:int=5, populationSize : int = 100)
		{
			this.generations = generations;
			this.populationSize = populationSize;
		}
		
		private var generations : int;
		private var populationSize : int;
	}
}