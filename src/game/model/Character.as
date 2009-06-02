package game.model
{
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Paul Gibler
	 */
	public class Character 
	{
		
		public function get Position():Point
		{
			return position;
		}
		
		public function get Tendencies():Tendencies
		{
			return tendencies;
		}
		
		public function Character() 
		{
			
		}
		
		private var position : Point;
		private var tendencies : Tendencies;
		
	}
	
}