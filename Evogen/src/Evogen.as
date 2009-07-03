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
			//testGA();
			testGame();
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
			var breederSettings:BreederSettings = new BreederSettings(new RankBreeder(2.0/3.0), new FighterSpecimenEvaluator(), 20, 100);
			ga = new GeneticAlgorithmRunner(breederSettings, tournamentSettings, gameSettings, stage);
			
			trace("Initial population:");
			ga.Players.forEach(function(player:Player, i:int, vec:Vector.<Player>):void
			{
				trace(i + " : " + player.BreedableSpecimen.SpecimenChromosome);
			});
			
			ga.addEventListener(GeneticAlgorithmEvent.COMPLETE, gaComplete);
			
			ga.Run();
		}
		
		private function gaComplete(event:Event):void
		{
			var specimens:Vector.<Specimen> = new Vector.<Specimen>();
			ga.Players.forEach(function(player:Player, i:int, vec:Vector.<Player>):void
			{
				specimens.push(player.BreedableSpecimen);
			});
			
			trace("Most fit specimens are:");
			specimens.forEach(function(spec:Specimen, i:int, vec:Vector.<Specimen>):void
			{
				trace(i + " : " + spec.SpecimenChromosome);
			});
			trace("Average top player fitnesses:");
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
			var p1dna : String = "0282071803340666048205180070093000710929055904410790021003100690025801010081005600550083010602610050016701930186006701140094013001290125003301220179014501700098012801010275016701900001013200050102004301800177010301510060018401090037015902070081028100830042019100860115013700410172020500530189010702240020025101100066003205550445045905410486051408660134053804620130087003220678075002500225000400140225013000650160017601380156002401740173013501680032005502010057014701890114023000080122017401800151018500390064008600260197004301340035022001690177017101000162016201670165004200320044003102210039018200080164031100380000016502010216010302700007";
			var p2dna : String = "0282071803340666048205180070093000710929055904410790021003100690025801010081005600550083010602610050016701930186006701140094013001290125003301220179014501700098012801010275016701900001013200050102004301800177010301510060018401090037015902070081028100830042019100860115013700410172020500530189010702240020025101100066003205550445045905410486051408660134053804620130087003220678075002500225000400140225013000650160017601380156002401740173013501680032005502010057014701890114023000080122017401800151018500390064008600260197004301340035022001690177017101000162016201670165004200320044003102210039018200080164031100380000016502010216010302700007";
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
		
	}
	
}