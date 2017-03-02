package fighter.model.breeder
{
	import org.evogen.breeder.Breeder;
	import org.evogen.breeder.SpecimenEvaluator;

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
		
		public function get SettingsBreeder():Breeder
		{
			return settingsBreeder
		}
		
		public function get Evaluator():SpecimenEvaluator
		{
			return evaluator;
		}
		
		public function BreederSettings(breeder : Breeder, evaluator : SpecimenEvaluator, generations:int=5, populationSize : int = 100)
		{
			this.generations = generations;
			this.populationSize = populationSize;
			this.settingsBreeder = breeder;
			this.evaluator = evaluator;
		}
		
		private var evaluator : SpecimenEvaluator;
		private var settingsBreeder : Breeder;
		private var generations : int;
		private var populationSize : int;
	}
}