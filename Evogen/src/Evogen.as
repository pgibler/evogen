package 
{
	import fighter.controller.breeder.FighterSpecimenEvaluator;
	import fighter.controller.player.PlayerController;
	import fighter.controller.player.production.HumanProductionTemplate;
	import fighter.controller.player.production.Production;
	import fighter.controller.player.production.ProductionTemplate;
	import fighter.controller.runner.GeneticAlgorithmRunner;
	import fighter.event.GeneticAlgorithmEvent;
	import fighter.model.breeder.BreederSettings;
	import fighter.model.game.Game;
	import fighter.model.game.GameSettings;
	import fighter.model.player.Player;
	import fighter.model.tournament.TournamentSettings;
	import fighter.view.CammyAnimations;
	import fighter.util.KeyObject;
	
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
			testGA();
		}
		
		private var ga : GeneticAlgorithmRunner;
		
		private function testGA():void
		{
			
			var gameSettings : GameSettings = new GameSettings(stage, Game.SIMULATION);
			var tournamentSettings : TournamentSettings = new TournamentSettings();
			var breederSettings:BreederSettings = new BreederSettings(new TwoThirdsRatioBreeder(), new FighterSpecimenEvaluator(), 5, 100);
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