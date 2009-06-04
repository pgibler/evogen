package game.model.player
{
	import flash.geom.Point;
	import org.evogen.entity.Specimen;
	
	/**
	 * ...
	 * @author Paul Gibler
	 */
	public class Player
	{
		
		public function get PlayerSpecimen():Specimen
		{
			return specimen;
		}
		
		public function get Position():Point
		{
			return position;
		}
		
		public function GetTendencies():Tendencies
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
		
		public function Player(specimen:Specimen)
		{
			this.specimen = specimen;
		}
		
		private var specimen : Specimen;
		private var currentAction : String;
		private var position : Point;
		private var tendencies : Tendencies;
		
	}
	
}