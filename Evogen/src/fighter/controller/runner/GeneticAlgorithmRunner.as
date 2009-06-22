package fighter.controller.runner
{
	import fighter.controller.callback.TournamentCallback;
	import fighter.controller.callback.TournamentCallbackImpl;
	import fighter.controller.player.PlayerController;
	import fighter.controller.player.production.ComputerProductionTemplate;
	import fighter.controller.player.production.Production;
	import fighter.model.breeder.BreederSettings;
	import fighter.model.game.Game;
	import fighter.model.game.GameSettings;
	import fighter.model.player.Player;
	import fighter.model.tournament.Tournament;
	import fighter.model.tournament.TournamentSettings;
	
	import flash.events.Event;
	
	import org.evogen.entity.Specimen;
	import org.evogen.genetics.chromosome.Chromosome;
	
	public class GeneticAlgorithmRunner
	{
		
		public function get Players():Vector.<Player>
		{
			return players;
		}
		
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
			this.currentGeneration = 1;
			this.mostFitSpecimens = new Vector.<Specimen>();
			this.players = GenerateInitialPlayers(breederSettings.PopulationSize);
		}
		
		public function Run():Vector.<Specimen>
		{
			while(!this.isComplete)
			{
				Update();
			}
			return mostFitSpecimens;
		}
		
		public function Update(event:Event = null):void
		{
			if(tournament == null)
			{
				trace("Starting tournaments...");
				StartTournament(players);
			}
			else if(tournament.IsComplete)
			{
				if(currentGeneration < breederSettings.Generations)
				{
					currentGeneration++;
					SpawnNextGeneration();
				}
				else
				{
					trace("Genetic algorithm runner completed.");
					this.isComplete = true;
					this.tournament.Players.forEach(function(player:Player, index:int, vec:Vector.<Player>):void
					{
						mostFitSpecimens.push(player.BreedableSpecimen);
					});
					mostFitSpecimens = breederSettings.Evaluator.SortSpecimens(mostFitSpecimens);
				}
			}
			else
			{
				tourneyCallback.OnTournamentUpdate( tournament, tournament.CurrentGame );
			}
		}
		
		private function StartTournament(players:Vector.<Player>):void
		{
			trace("Running Tournament "+currentGeneration+" with population size " + players.length + " with top player " + players[0].BreedableSpecimen.SpecimenChromosome);
			tourneyCallback = new TournamentCallbackImpl();			
			this.tournament = new Tournament(tourneyCallback , players, players[0], tournamentSettings, gameSettings);
			tourneyCallback.OnTournamentStart( tournament );
		}
		
		private function SpawnNextGeneration():void
		{
			var specimens : Vector.<Specimen> = new Vector.<Specimen>();
			players.forEach(function(player:Player, index:int, vec:Vector.<Player>):void
			{
				specimens.push( player.BreedableSpecimen );
			});
			var chromosomes : Vector.<Chromosome> = breederSettings.SettingsBreeder.Breed(specimens, breederSettings.Evaluator);
			players = GeneratePlayers(chromosomes);
			StartTournament(players);
		}
		
		private function GeneratePlayers(chromosomes:Vector.<Chromosome>):Vector.<Player>
		{
			var returnme : Vector.<Player> = new Vector.<Player>();
			var generator : ComputerProductionTemplate = new ComputerProductionTemplate();
			for each(var c : Chromosome in chromosomes)
			{
				var rules : Production = generator.GenerateProductionFromChromosome(c);
				var spec : Specimen = new Specimen(c);
				returnme.push( new Player(new PlayerController(rules), spec) );
			}
			return returnme;
		}
		
		private function GenerateInitialPlayers(populationSize:int):Vector.<Player>
		{
			players = new Vector.<Player>();
			var compProd : ComputerProductionTemplate = new ComputerProductionTemplate();
			for(var i : int = 0 ; i < populationSize; i++)
			{
				var prod : Production = compProd.GenerateProduction();
				var spec : Specimen = new Specimen(compProd.LastGeneratedProductionChromosome);
				players.push( new Player( new PlayerController( prod ), spec ) );
			}
			return players;
		}
		
		private var players : Vector.<Player>;
		private var mostFitSpecimens : Vector.<Specimen>;
		private var isComplete : Boolean = false;
		private var currentGeneration : int;
		private var tourneyCallback : TournamentCallback;
		private var gameSettings : GameSettings;
		private var tournament : Tournament;
		private var breederSettings : BreederSettings;
		private var tournamentSettings : TournamentSettings;
	}
	
}