package fighter.controller.runner
{
	import fighter.model.tournament.Tournament;
	
	public class GeneticAlgorithmRunner
	{
		
		public static const SIMULATION : int = 0;
		public static const GRAPHICAL : int = 1;
		
		public function GeneticAlgorithmRunner(generations:int, mode:int)
		{
			this.generations = generations;
			this.currentGeneration = 0;
			this.mode = mode;
			this.tournament = new Tournament();
		}
		
		public function Start():void
		{
			currentGeneration = 0;
		}
		
		public function Update(event:Event = null):void
		{
			
		}
		
		private var tournament : Tournament;
		private var generations : int;
		private var currentGeneration : int;
	}
	
}