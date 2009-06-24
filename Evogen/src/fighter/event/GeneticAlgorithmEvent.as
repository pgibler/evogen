package fighter.event
{
	import flash.events.Event;
	
	public class GeneticAlgorithmEvent extends Event
	{
		
		public static const COMPLETE : String = "ga_complete";
		
		public function GeneticAlgorithmEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}