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
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.getTimer;
	
	import org.evogen.breeder.TwoThirdsRatioBreeder;
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
		
		private function testGA():void
		{
			var gameSettings : GameSettings = new GameSettings(stage, Game.SIMULATION);
			var tournamentSettings : TournamentSettings = new TournamentSettings();
			var breederSettings:BreederSettings = new BreederSettings(new TwoThirdsRatioBreeder(), new FighterSpecimenEvaluator(), 20, 100);
			ga = new GeneticAlgorithmRunner(breederSettings, tournamentSettings, gameSettings);
			
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
			trace("Algorithm run time: "+(getTimer()/1000)+" seconds");
		}
		
		private function testGame():void
		{
			
			//KeyObject.initialize(stage);
			var gameSettings : GameSettings = new GameSettings(stage, Game.GRAPHICAL);
			var p1dna : String = "0231076902070793013408660406059403600640071202880688031202910709003600350076023800290270001403020203019200760150021000590002010800190235009401990176005200600165021700330018019201380153008601630134022900100200007700770121015101250230016502650020010800260061022100240232020500280062001102170003013201640093015301880187008009770023048405160208079204050595056504350259074105150485033006700138019900100083019600830155013600060099024000770052021801470160005101910009014800820018028402160043020300150139019100750204013000230191017700600061005002790158017701980029005801050177007301820157009601130230018201400063002001140096016201980088012601820035";
			var p2dna : String = "0590041005420458062803720113088707270273016508350754024602970703005202680124015601580023018200370131015600050000012603070228004701830236006301860232002200600019000302160163004401880169015600600134022900100200007700770121015101250230016502650020010800260061022100240232020500280062001102170003013201640093015301880187008004340566012908710208079204750525057604240445055505150485033006700138019900100083019600830155013600060099024000770052021801470160005101910009014800820018028402160043020300150139019100750204013000230191017700600061005002790158017701980029005801050177007301820157009601130230018201400063002001140096016201980088012601820035";
			var prodTemp : ComputerProductionTemplate = new ComputerProductionTemplate();
			var prod : Production = prodTemp.GenerateProductionFromDNA(p1dna);
			var pc : PlayerController = new PlayerController(prod);
			var p1 : Player = new Player(pc, new Specimen(prodTemp.LastGeneratedProductionChromosome));
			prod = prodTemp.GenerateProductionFromDNA(p2dna);
			pc = new PlayerController(prod);
			var p2 : Player = new Player(pc, new Specimen(prodTemp.LastGeneratedProductionChromosome));
			var game : Game = new Game(p1, p2, new DefaultLevel(), new GameCallbackImpl(), gameSettings);
			//var tourney : Tournament = new Tournament(new TournamentCallbackImpl(),
			var gr : GameRunner = new GameRunner(new GameCallbackImpl(), game);
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