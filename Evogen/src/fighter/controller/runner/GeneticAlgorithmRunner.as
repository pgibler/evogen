package fighter.controller.runner
{
	import fighter.controller.callback.TournamentCallback;
	import fighter.controller.callback.TournamentCallbackImpl;
	import fighter.controller.player.PlayerController;
	import fighter.controller.player.production.ComputerProductionTemplate;
	import fighter.model.player.Player;
	import fighter.model.tournament.Tournament;
	
	import flash.events.Event;
	
	import org.evogen.entity.Specimen;
	
	public class GeneticAlgorithmRunner
	{
		
		public static const SIMULATION : int = 0;
		public static const GRAPHICAL : int = 1;
		
		public function GeneticAlgorithmRunner(generations:int, populationSize : int = 100, frameIntervalsPerTick:int = 100, gamesToWinMatch : int = 1, mode:int = 0)
		{
			if(populationSize <= 2)
			{
				throw new Error("Population size must be greater than 2");
			}
			if(frameIntervalsPerTick <= 0)
			{
				throw new Error("Frame intervals per tick must be greater than 0");
			}
			if(gamesToWinMatch <= 0)
			{
				throw new Error("Games to win match must be greater than 0");
			}
			if(mode != GeneticAlgorithmRunner.SIMULATION && mode != GeneticAlgorithmRunner.GRAPHICAL)
			{
				throw new Error("Genetic algorithm runner mode must be SIMULATION or GRAPHICAL");
			}
			this.generations = generations;
			this.frameIntervalsPerTick = frameIntervalsPerTick;
			this.populationSize = populationSize;
			this.currentGeneration = 0;
			this.mode = mode;
			trace("Starting tournaments...");
			StartTournament(currentGeneration);
		}
		
		public function Update(event:Event = null):void
		{
			for(var i : int = 0; i < frameIntervalsPerTick; i++)
			{
				if(tournament.IsComplete)
				{
					if(currentGeneration < generations)
					{
						currentGeneration++;
					}
				}
				else
				{
					tourneyCallback.OnTournamentUpdate( tournament, tournament.CurrentGame );
				}
			}
		}
		
		private function StartTournament(currGen:int):void
		{
			var players : Vector.<Player> = GeneratePlayers(populationSize);
			trace("Running Tournament "+currGen+" with population size " + populationSize + " with top player " + players[0]);
			tourneyCallback = new TournamentCallbackImpl();			
			this.tournament = new Tournament(tourneyCallback , players, players[0], gamesToWinMatch);
			tourneyCallback.OnTournamentStart( tournament );
		}
		
		private function GeneratePlayers(populationSize:int):Vector.<Player>
		{
			var players : Vector.<Player> = new Vector.<Player>();
			var compProd : ComputerProductionTemplate = new ComputerProductionTemplate();
			for(var i : int = 0 ; i < populationSize; i++)
			{
				players.push( new Player( new PlayerController( compProd.GenerateProduction() ), new Specimen(compProd.LastGeneratedProductionChromosome) ) );
			}
			return players;
		}
		
		private var tourneyCallback : TournamentCallback;
		private var gamesToWinMatch: int;
		private var populationSize : int;
		private var mode : int;
		private var tournament : Tournament;
		private var frameIntervalsPerTick : int;
		private var generations : int;
		private var currentGeneration : int;
	}
	
}