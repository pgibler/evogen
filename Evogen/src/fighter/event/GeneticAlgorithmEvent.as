package fighter.event
{
	import flash.events.Event;
	
	import org.evogen.entity.Population;
	
	public class GeneticAlgorithmEvent extends Event
	{
		
		public static const COMPLETE : String = "ga_complete";
		
		public function get TopPopulation():Population
		{
			return population;
		}
		
		public function GeneticAlgorithmEvent(type:String, population:Population, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.population = population;
		}
		
		private var population : Population;
	}
}