package 
{
	import adobe.utils.CustomActions;
	import fighter.model.game.Level;
	import fighter.util.KeyObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.getQualifiedClassName;
	import fighter.controller.callback.GameCallbackImpl;
	import fighter.controller.player.PlayerController;
	import fighter.controller.runner.GameRunner;
	import fighter.model.game.Game;
	import fighter.controller.player.production.HumanProductionTemplate;
	import fighter.controller.player.production.Production;
	import fighter.controller.player.production.ProductionTemplate;
	import fighter.model.player.Player;
	import fighter.model.tournament.TournamentSettings;
	import org.evogen.entity.Breeder;
	import org.evogen.genetics.chromosome.Chromosome;
	import org.evogen.genetics.chromosome.ChromosomeTemplate;
	import org.evogen.genetics.trait.*;
	import org.evogen.entity.Specimen;
	
	/**
	 * ...
	 * @author Paul Gibler
	 */
	public class Main extends Sprite 
	{
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			testAngle();
			
		}
		
		private var spr : Sprite = new Sprite();
		private function testAngle():void
		{
			stage.addChild(spr);
			stage.addEventListener(Event.ENTER_FRAME, draw);
		}
		private function draw(e:Event):void
		{
			spr.graphics.clear();
			spr.graphics.lineStyle(1, 0x00FF00);
			spr.graphics.moveTo(0, 0);
			spr.graphics.lineTo(mouseX, mouseY);
		}
		
		private function testGame():void
		{
			KeyObject.initialize(stage);
			
			var prodTemp : ProductionTemplate = new HumanProductionTemplate();
			var prod : Production = prodTemp.GenerateProduction();
			var pc : PlayerController = new PlayerController(prod);
			var p1 : Player = new Player(pc);
			prod = prodTemp.GenerateProduction();
			pc = new PlayerController(prod);
			var p2 : Player = new Player(pc);
			var game : Game = new Game(p1, p2, new Level(null, null));
			var gr : GameRunner = new GameRunner(new GameCallbackImpl(), game, new TournamentSettings());
			
			gr.Start();
			
			addEventListener(Event.ENTER_FRAME, gr.Update);
		}
		
		private function testGenetics():void
		{
			var ct : ChromosomeTemplate = new ChromosomeTemplate();
			ct.AddTraitTemplate(new ProbabilisticTraitTemplate("crouching").AddState("attack").AddState("stand").AddState("jump"));
			ct.AddTraitTemplate(new ContinuousTraitTemplate("penis"));
			ct.AddTraitTemplate(new DiscreteTraitTemplate("hair color")	.AddState("a").AddState("b").AddState("c").AddState("d").AddState("e").AddState("f")
																		.AddState("g").AddState("h").AddState("i").AddState("j").AddState("k"));
			
			ct.AddTraitTemplate(new BinaryTraitTemplate("left-handed"));
			ct.AddTraitTemplate(new BinaryTraitTemplate("right-handed"));
			trace(ct.Traits);
			
			var c : Chromosome = ct.GenerateRandomChromosome();
			trace(c.ToDNA());
			trace(c.Mutate(.5).ToDNA());
			
			var b : Breeder = new Breeder(function Fitness(specimen:Specimen):Number
			{
				return 1;
			});
		}
		
	}
	
}