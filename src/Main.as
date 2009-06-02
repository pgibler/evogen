package 
{
	import adobe.utils.CustomActions;
	import flash.display.Sprite;
	import flash.events.Event;
	import org.evogen.BinaryTraitTemplate;
	import org.evogen.Breeder;
	import org.evogen.Chromosome;
	import org.evogen.ChromosomeTemplate;
	import org.evogen.ContinuousTraitTemplate;
	import org.evogen.DiscreteTraitTemplate;
	import org.evogen.FuzzyTraitTemplate;
	import org.evogen.Specimen;
	
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
			
			var ct : ChromosomeTemplate = new ChromosomeTemplate();
			/*ct.addTraitTemplate(new FuzzyTraitTemplate("crouching").addState("attack").addState("stand").addState("jump"));
			ct.addTraitTemplate(new ContinuousTraitTemplate("penis"));
			ct.addTraitTemplate(new DiscreteTraitTemplate("hair color")	.addState("a").addState("b").addState("c").addState("d").addState("e").addState("f")
																		.addState("g").addState("h").addState("i").addState("j").addState("k"));
			*/
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