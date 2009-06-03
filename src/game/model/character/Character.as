package game.model.character
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
		
		public function get ActionTendencies():Tendencies
		{
			return tendencies;
		}
		
		public function get CurrentAction():String
		{
			return currentAction;
		}
		
		public function IsAttacking():Boolean
		{
			return currentAction == "attacking";
		}
		
		private var currentAction : String;
		private var position : Point;
		private var tendencies : Tendencies;
		
	}
	
}