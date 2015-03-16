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
	import org.evogen.specimen.Specimen;
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
			//testGame();
			testGA();
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
			var breederSettings:BreederSettings = new BreederSettings(new RankBreeder(2.0/3.0), new FighterSpecimenEvaluator(), 100, 100);
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
			var specimens : Vector.<Specimen> = event.TopPopulation.Specimens;
			
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
			var p1dna : String = "04610539034506550428057203250675007500640121006501960231021400330179011901580156000001670158006200620126015901040156025200720069014102170038007201100214017000380722027806540346034206580416058400030210001300550074018102610201024400020183010502670128002100510070018501800086015001420071011700750231008802190267006100230037";
			var p2dna : String = "01140886022207780469053100260974012701910141011500160129022800520003022002560137005001740138002400040155003401160118019801560219001100200162002600110177012704660906009401030897081801820971002901030036015001450144014601410135015401080094006101220111018001680208006600010114009400170278022300120139021800800191018700240148";
			var p3dna : String = "04000600051504850181081903130687012301830144012200840055016901200088020000320134000201000229021600360047005400890117029200810284005600200008021400400225022702100432056803000700031006900840016001080036004301840161023802180012014001230167012000810266004500580106002000830010032501730264001700120022019401530057021701320214";
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