package fighter.event
{
	import flash.events.Event;
	
	import org.evogen.entity.Specimen;
	
	public class GeneticAlgorithmEvent extends Event
	{
		
		public static const COMPLETE : String = "ga_complete";
		
		public function get Specimens():Vector.<Specimen>
		{
			return specimens;
		}
		
		public function GeneticAlgorithmEvent(type:String, specimens:Vector.<Specimen>, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.specimens = specimens;
		}
		
		private var specimens : Vector.<Specimen>;
	}
}