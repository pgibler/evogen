package fighter.controller.runner
{
	import fighter.controller.callback.TournamentCallback;
	import fighter.controller.callback.TournamentCallbackImpl;
	import fighter.controller.player.PlayerController;
	import fighter.controller.player.production.ComputerProductionTemplate;
	import fighter.model.breeder.BreederSettings;
	import fighter.model.game.Game;
	import fighter.model.game.GameSettings;
	import fighter.model.player.Player;
	import fighter.model.tournament.Tournament;
	import fighter.model.tournament.TournamentSettings;
	
	import flash.events.Event;
	
	import org.evogen.entity.Specimen;
	
	public class GeneticAlgorithmRunner
	{
		
		public function GeneticAlgorithmRunner(breederSettings:BreederSettings, tournamentSettings:TournamentSettings, gameSettings:GameSettings)
		{
			if(breederSettings.PopulationSize <= 2)
			{
				throw new Error("Population size must be greater than 2");
			}
			if(gameSettings.FrameIntervalsPerTick <= 0)
			{
				throw new Error("Frame intervals per tick must be greater than 0");
			}
			if(tournamentSettings.GameWinsToWinMatch <= 0)
			{
				throw new Error("Games to win match must be greater than 0");
			}
			if(gameSettings.Mode != Game.SIMULATION && gameSettings.Mode != Game.GRAPHICAL)
			{
				throw new Error("Genetic algorithm runner mode must be SIMULATION or GRAPHICAL");
			}
			this.gameSettings = gameSettings;
			this.tournamentSettings = tournamentSettings;
			this.breederSettings = breederSettings;
			trace("Starting tournaments...");
			StartTournament(currentGeneration);
		}
		
		public function Update(event:Event = null):void
		{
			if(tournament.IsComplete)
			{
				if(currentGeneration < breederSettings.Generations)
				{
					currentGeneration++;
					SpawnNextGeneration();
				}
				else
				{
					trace("Genetic algorithm runner completed.");
				}
			}
			else
			{
				tourneyCallback.OnTournamentUpdate( tournament, tournament.CurrentGame );
			}
		}
		
		private function StartTournament(currGen:int):void
		{
			var players : Vector.<Player> = GeneratePlayers(breederSettings.PopulationSize);
			trace("Running Tournament "+currGen+" with population size " + breederSettings.PopulationSize + " with top player " + players[0]);
			tourneyCallback = new TournamentCallbackImpl();			
			this.tournament = new Tournament(tourneyCallback , players, players[0], tournamentSettings, gameSettings);
			tourneyCallback.OnTournamentStart( tournament );
		}
		
		private function SpawnNextGeneration():void
		{
			var specimens : Vector.<Specimen> = this.tournament.Players.map(function(player:Player, index:int, vec:Vector.<Player>):Specimen
			{
				return player.PlayerSpecimen
			}
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
		
		private var currentGeneration : int;
		private var tourneyCallback : TournamentCallback;
		private var gameSettings : GameSettings;
		private var tournament : Tournament;
		private var breederSettings : BreederSettings;
		private var tournamentSettings : TournamentSettings;
	}
	
}