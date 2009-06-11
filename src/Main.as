﻿package 
{
	import adobe.utils.CustomActions;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.getQualifiedClassName;
	import game.controller.callback.MatchCallbackImpl;
	import game.controller.player.PlayerController;
	import game.controller.runner.MatchRunner;
	import game.model.match.Match;
	import game.model.player.condition.Production;
	import game.model.player.Player;
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
			testMatch();
			
		}
		
		private function testMatch():void
		{
			var prod : Production = new PlayerProduction
			var pc : PlayerController = new PlayerController(
			var p1 : Player = new Player(
			var match : Match = new Match(
			var mr : MatchRunner = new MatchRunner(new MatchCallbackImpl(), 
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