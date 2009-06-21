package 
{
	import breeder.FighterSpecimenEvaluator;
	
	import fighter.controller.player.PlayerController;
	import fighter.controller.player.production.HumanProductionTemplate;
	import fighter.controller.player.production.Production;
	import fighter.controller.player.production.ProductionTemplate;
	import fighter.controller.runner.GeneticAlgorithmRunner;
	import fighter.model.breeder.BreederSettings;
	import fighter.model.game.GameSettings;
	import fighter.model.tournament.TournamentSettings;
	import fighter.util.KeyObject;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import org.evogen.breeder.TwoThirdsRatioBreeder;
	import org.evogen.genetics.chromosome.Chromosome;
	import org.evogen.genetics.chromosome.ChromosomeTemplate;
	import org.evogen.genetics.trait.*;

	/**
	 * ...
	 * @author Paul Gibler
	 */
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
			
		}
		
		private function testGA():void
		{
			var gameSettings : GameSettings = new GameSettings();
			var tournamentSettings : TournamentSettings = new TournamentSettings();
			var breederSettings:BreederSettings = new BreederSettings(new TwoThirdsRatioBreeder(), new FighterSpecimenEvaluator(), 5,50);
			var ga : GeneticAlgorithmRunner = new GeneticAlgorithmRunner(breederSettings, tournamentSettings, gameSettings);
			ga.Run();
		}
		
		private function testGame():void
		{
			
			KeyObject.initialize(stage);
			
			var prodTemp : ProductionTemplate = new HumanProductionTemplate();
			var prod : Production = prodTemp.GenerateProduction();
			var pc : PlayerController = new PlayerController(prod);
			//var p1 : Player = new Player(pc);
			prod = prodTemp.GenerateProduction();
			pc = new PlayerController(prod);
			//var p2 : Player = new Player(pc);
			//var game : Game = new Game(p1, p2, new Level(null, null));
			//var tourney : Tournament = new Tournament(new TournamentCallbackImpl(),
			//var gr : GameRunner = new GameRunner(new GameCallbackImpl(), game, tourney);
			
			//gr.Start();
			
			//addEventListener(Event.ENTER_FRAME, gr.Update);
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