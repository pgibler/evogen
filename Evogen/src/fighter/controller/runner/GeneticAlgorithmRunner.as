package fighter.controller.runner
{
	import fighter.controller.callback.TournamentCallback;
	import fighter.controller.callback.TournamentCallbackImpl;
	import fighter.controller.player.PlayerController;
	import fighter.controller.player.production.ComputerProductionTemplate;
	import fighter.controller.player.production.Production;
	import fighter.event.GeneticAlgorithmEvent;
	import fighter.model.breeder.BreederSettings;
	import fighter.model.game.Game;
	import fighter.model.game.GameSettings;
	import fighter.model.player.Player;
	import fighter.model.tournament.Tournament;
	import fighter.model.tournament.TournamentSettings;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.Timer;
	
	import org.evogen.entity.Specimen;
	import org.evogen.genetics.chromosome.Chromosome;
	
	public class GeneticAlgorithmRunner extends EventDispatcher
	{
		
		public function get GAGameSettings():GameSettings
		{
			return gameSettings;
		}
		
		public function get GATournamentSettings():TournamentSettings
		{
			return tournamentSettings;
		}
		
		public function get GABreederSettings():BreederSettings
		{
			return breederSettings;
		}
		
		public function get AverageTopPlayerFitnesses():Vector.<Number>
		{
			return averageTopPlayerFitnesses;
		}
		
		public function get AverageTournamentPopulationFitnesses():Vector.<Number>
		{
			return averageTournamentPopulationFitnesses;
		}
		
		public function get Players():Vector.<Player>
		{
			
			return players;
		}
		
		public function GeneticAlgorithmRunner(breederSettings:BreederSettings, tournamentSettings:TournamentSettings, gameSettings:GameSettings, displayContainer:DisplayObjectContainer)
		{
			if(breederSettings.PopulationSize <= 1)
			{
				throw new Error("Population size must be greater than 1");
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
			this.algorithmTimer = new Timer(0);
			this.interfaceContainer = new Sprite();
			this.averageTournamentPopulationFitnesses = new Vector.<Number>();
			this.averageTopPlayerFitnesses = new Vector.<Number>();
			displayContainer.addChild(interfaceContainer);
			
			GenerateInterface();
		}
		
		public function Run():void
		{
			if(gameSettings.Mode == Game.SIMULATION)
			{
				this.algorithmTimer.addEventListener(TimerEvent.TIMER, Update);
			}
			else if(gameSettings.Mode == Game.GRAPHICAL)
			{
				this.gameSettings.DisplayContainer.addEventListener(Event.ENTER_FRAME, Update);
			}
			this.algorithmTimer.start();
		}
		
		public function SwitchMode(newMode:int):void
		{
			if(newMode == Game.SIMULATION && gameSettings.Mode == Game.GRAPHICAL)
			{
				this.gameSettings.DisplayContainer.removeEventListener(Event.ENTER_FRAME, Update);
				this.algorithmTimer.addEventListener(TimerEvent.TIMER, Update);
			}
			else if(newMode == Game.GRAPHICAL && gameSettings.Mode == Game.SIMULATION)
			{
				this.algorithmTimer.removeEventListener(TimerEvent.TIMER, Update);
				this.gameSettings.DisplayContainer.addEventListener(Event.ENTER_FRAME, Update);
			}
			gameSettings.Mode = newMode;
		}
		
		private function Update(event:Event = null):void
		{
			if(this.isComplete)
			{
				if(gameSettings.Mode == Game.SIMULATION)
				{
					this.algorithmTimer.stop();
				} 
				else if(gameSettings.Mode == Game.GRAPHICAL)
				{
					this.gameSettings.DisplayContainer.removeEventListener(Event.ENTER_FRAME, Update);
				}
				var specs :Vector.<Specimen> = new Vector.<Specimen>();
				tournament.Players.forEach(function(player:Player, index:int, vec:Vector.<Player>):void
				{
					specs.push(player.BreedableSpecimen);
				});
				var ev : GeneticAlgorithmEvent = new GeneticAlgorithmEvent(GeneticAlgorithmEvent.COMPLETE, specs);
				this.dispatchEvent(ev);
			}
			else if(tournament == null)
			{
				trace("Starting tournaments...");
				StartTournament(players);
			}
			else if(tournament.IsComplete)
			{
				if(currentGeneration < breederSettings.Generations)
				{
					currentGeneration++;
					var totalCharacterFitness : Number = 0;
					var populationSize : Number = tournament.Players.length;
					var evaluate : Function = breederSettings.Evaluator.EvaluateFitness;
					tournament.Players.forEach(function(player:Player, index:int, vec:Vector.<Player>):void
					{
						totalCharacterFitness += evaluate(player.BreedableSpecimen);
					});
					
					var averageCharacterFitness : Number = totalCharacterFitness/populationSize;
					var topCharacterFitness : Number = evaluate(tournament.TopPlayer.BreedableSpecimen);
					averageTopPlayerFitnesses.push(topCharacterFitness);
					averageTournamentPopulationFitnesses.push(averageCharacterFitness);
					
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
		
		private function ChangeMode(mouseEvent:MouseEvent):void
		{
			var newMode : int = gameSettings.Mode == Game.GRAPHICAL ? Game.SIMULATION : Game.GRAPHICAL;
			SwitchMode(newMode);
		}
		
		private function GenerateInterface():void
		{
			var img : Sprite = new Sprite();
			var txtfld : TextField = new TextField();
			var btn : SimpleButton;
			img.graphics.lineStyle(1,0x001100);
			img.graphics.beginFill(0xFFFFFF);
			img.graphics.drawRect(0,0,100,30);
			img.graphics.endFill();
			//img.addChild(txtfld);
			txtfld.text = "Toggle Run Mode";
			txtfld.textColor = 0x00FF00;
			btn = new SimpleButton(txtfld, txtfld, txtfld, txtfld);
			interfaceContainer.addChild(btn);
			btn.x = 100;
			btn.y = 500;
			
			btn.addEventListener(MouseEvent.CLICK, ChangeMode);
		}
		
		private var interfaceContainer : DisplayObjectContainer;
		private var algorithmTimer : Timer;
		private var averageTournamentPopulationFitnesses : Vector.<Number>;
		private var averageTopPlayerFitnesses : Vector.<Number>;
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