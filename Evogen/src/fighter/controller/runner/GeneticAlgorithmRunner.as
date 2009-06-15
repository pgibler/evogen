package fighter.controller.runner
{
	import fighter.controller.callback.TournamentCallbackImpl;
	import fighter.controller.player.PlayerController;
	import fighter.controller.player.production.ComputerProductionTemplate;
	import fighter.controller.player.production.ProductionTemplate;
	import fighter.model.player.Player;
	import fighter.model.tournament.Tournament;
	
	import flash.events.Event;
	
	public class GeneticAlgorithmRunner
	{
		
		public static const SIMULATION : int = 0;
		public static const GRAPHICAL : int = 1;
		
		public function GeneticAlgorithmRunner(generations:int, populationSize : int = 100, frameIntervalsPerTick:int = 100, gamesToWinMatch : int = 1, mode:int = 0)
		{
			this.generations = generations;
			this.frameIntervalsPerTick = frameIntervalsPerTick;
			this.populationSize = populationSize;
			this.currentGeneration = 0;
			this.mode = mode;
			var players : Vector.<Player> = GeneratePlayers(populationSize);
			this.tournament = new Tournament( new TournamentCallbackImpl(), players, players[0], gamesToWinMatch);
		}
		
		public function Update(event:Event = null):void
		{
			
		}
		
		private function GeneratePlayers(populationSize:int):Vector.<Player>
		{
			var players : Vector.<Player> = new Vector.<Player>();
			var compProd : ProductionTemplate = new ComputerProductionTemplate();
			for(var i : int = 0 ; i < populationSize; i++)
			{
				players.push( new Player( new PlayerController( compProd.GenerateProduction() ) ) );
			}
			return players;
		}
		
		private var gamesToWinMatch: int;
		private var populationSize : int;
		private var mode : int;
		private var tournament : Tournament;
		private var frameIntervalsPerTick : int;
		private var generations : int;
		private var currentGeneration : int;
	}
	
}