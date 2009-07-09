package 
{
	import fighter.controller.breeder.FighterSpecimenEvaluator;
	import fighter.controller.callback.GameCallbackImpl;
	import fighter.controller.player.PlayerController;
	import fighter.controller.player.production.ComputerProductionTemplate;
	import fighter.controller.player.production.Production;
	import fighter.controller.runner.GameRunner;
	import fighter.controller.runner.GeneticAlgorithmRunner;
	import fighter.event.GeneticAlgorithmEvent;
	import fighter.model.breeder.BreederSettings;
	import fighter.model.game.DefaultLevel;
	import fighter.model.game.Game;
	import fighter.model.game.GameSettings;
	import fighter.model.player.Player;
	import fighter.model.tournament.TournamentSettings;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.getTimer;
	
	import org.evogen.breeder.RankBreeder;
	import org.evogen.entity.Population;
	import org.evogen.entity.PopulationPool;
	import org.evogen.entity.Specimen;
	import org.evogen.genetics.chromosome.Chromosome;
	import org.evogen.genetics.chromosome.ChromosomeTemplate;
	import org.evogen.genetics.trait.*;

	/**
	 * ...
	 * @author Paul Gibler
	 */
	[SWF(width="800", height="600", backgroundColor="0x000000", frameRate="30")]
	public class Evogen extends Sprite 
	{
		
		public function Evogen() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			testGA();
			//testGame();
			//testPopulationPool();
		}
		
		private var ga : GeneticAlgorithmRunner;
		private var gameContainer : Sprite;
		private var gamePlayContainer : Sprite;
		private var gameInterfaceContainer : Sprite;
		
		private function testGA():void
		{
			var gameContainer : DisplayObjectContainer = new Sprite();
			stage.addChild(gameContainer);
			var gameSettings : GameSettings = new GameSettings(gameContainer, Game.SIMULATION);
			var tournamentSettings : TournamentSettings = new TournamentSettings();
			var breederSettings:BreederSettings = new BreederSettings(new RankBreeder(2.0/3.0), new FighterSpecimenEvaluator(), 100, 5);
			ga = new GeneticAlgorithmRunner(breederSettings, tournamentSettings, gameSettings, stage);
			
			trace("Initial population:");
			ga.Players.forEach(function(player:Player, i:int, vec:Vector.<Player>):void
			{
				trace(i + " : " + player.BreedableSpecimen.SpecimenChromosome);
			});
			
			ga.addEventListener(GeneticAlgorithmEvent.COMPLETE, gaComplete);
			
			ga.Run();
		}
		
		private function gaComplete(event:GeneticAlgorithmEvent):void
		{
			var specimens : Vector.<Specimen> = event.Specimens;
			
			trace("Most fit specimens are:");
			specimens.forEach(function(spec:Specimen, i:int, vec:Vector.<Specimen>):void
			{
				trace(i + " : " + spec.SpecimenChromosome);
			});
			trace("Top player fitnesses:");
			ga.AverageTopPlayerFitnesses.forEach(function(num:Number, i:int, vec:Vector.<Number>):void
			{
				trace("Tournament " + i + " : " + num);
			});
			trace("Average population fitnesses:");
			ga.AverageTournamentPopulationFitnesses.forEach(function(num:Number, i:int, vec:Vector.<Number>):void
			{
				trace("Tournament " + i + " : " + num);
			});
			trace("Algorithm run time: "+(getTimer()/1000)+" seconds");
		}
		
		private function testGame():void
		{
			
			//KeyObject.initialize(stage);
			var gameSettings : GameSettings = new GameSettings(stage, Game.GRAPHICAL);
			var p1dna : String = "03790621031706830521047908860114014400150122013201080069017602340045022101610094014800790021023201880160025300220014021300070144012502060198000500410183000402390379062106300370076402360831016901730254000500090138018101790062030803040013002401760128003200150034001300550336001900370168033900920064012101580100015100920221";
			var p2dna : String = "04270573027807220535046503840616021000530086015000300142015401750010008100860173020300920179017500140319007802440059000302770006002100750212006702840161016400170488051209290071085701430240076000380099007301850195013301860090020901550185016701250045009200220036012500810274004901690014025200030261021100150071018801330117";
			var prodTemp : ComputerProductionTemplate = new ComputerProductionTemplate();
			var prod : Production = prodTemp.GenerateProductionFromDNA(p1dna);
			var pc : PlayerController = new PlayerController(prod);
			var p1 : Player = new Player(pc, new Specimen(prodTemp.LastGeneratedProductionChromosome));
			prod = prodTemp.GenerateProductionFromDNA(p2dna);
			pc = new PlayerController(prod);
			var p2 : Player = new Player(pc, new Specimen(prodTemp.LastGeneratedProductionChromosome));
			var game : Game = new Game(p1, p2, new DefaultLevel(), new GameCallbackImpl(), gameSettings);
			var gr : GameRunner = new GameRunner(game);
			gr.Start();
		}
		
		private function testGenetics():void
		{
			var ct : ChromosomeTemplate = new ChromosomeTemplate();
			ct.AddTraitTemplate(new ProbabilisticTraitTemplate("crouching").AddState("attack").AddState("stand").AddState("jump"));
			ct.AddTraitTemplate(new ContinuousTraitTemplate("member length"));
			ct.AddTraitTemplate(new DiscreteTraitTemplate("hair color")	.AddState("a").AddState("b").AddState("c").AddState("d").AddState("e").AddState("f")
																		.AddState("g").AddState("h").AddState("i").AddState("j").AddState("k"));
			
			ct.AddTraitTemplate(new BinaryTraitTemplate("left-handed"));
			ct.AddTraitTemplate(new BinaryTraitTemplate("right-handed"));
			trace(ct.Traits);
			
			var c : Chromosome = ct.GenerateRandomChromosome();
			trace(c.ToDNA());
			trace(c.Mutate(.5).ToDNA());
		}
		
		private function testPopulationPool():void
		{
			var p : PopulationPool = new PopulationPool(3);
			p.AddPopulation(new Vector.<Specimen>, 1);
			p.AddPopulation(new Vector.<Specimen>, 2);
			p.AddPopulation(new Vector.<Specimen>, 3);
			p.AddPopulation(new Vector.<Specimen>, 4);
			p.AddPopulation(new Vector.<Specimen>, 3);
			p.AddPopulation(new Vector.<Specimen>, 2);
			p.AddPopulation(new Vector.<Specimen>, 2);
			p.AddPopulation(new Vector.<Specimen>, 4);
			p.AddPopulation(new Vector.<Specimen>, 10);
			p.AddPopulation(new Vector.<Specimen>, 12);
			p.AddPopulation(new Vector.<Specimen>, 1);
			p.AddPopulation(new Vector.<Specimen>, -5);
			p.AddPopulation(new Vector.<Specimen>, 24);
			p.AddPopulation(new Vector.<Specimen>, 20);
			
		}
		
	}
	
}