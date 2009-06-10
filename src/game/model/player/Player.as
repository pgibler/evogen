package game.model.player
{
	import flash.display.Sprite;
	import flash.geom.Point;
	import game.model.match.Match;
	import game.model.player.action.ActionList;
	import org.evogen.entity.Specimen;
	
	/**
	 * ...
	 * @author Paul Gibler
	*/
	public class Player
	{
		
		public function get Health():Number
		{
			return health;
		}
		
		public function get HealthMax():Number
		{
			return Player.healthMax;
		}
		
		public function get DisplayContainer():Sprite
		{
			return displaycontainer;
		}
		
		public function get PlayerSpecimen():Specimen
		{
			return specimen;
		}
		
		public function get OnGround():Boolean
		{
			return displaycontainer.y <= GroundY;
		}
		
		public function get Position():Point
		{
			return position;
		}
		
		public function get CurrentMatch():Match
		{
			return this.currentMatch;
		}
		
		public function get CurrentOpponent():Player
		{
			return this.currentOpponent;
		}
		
		internal function set CurrentOpponent(opponent:Player):void
		{
			this.currentOpponent = opponent;
		}
		
		internal function set CurrentMatch(match:Match):void
		{
			this.currentMatch = match;
		}
		
		/**
		 * Returns the direction the player is facing. -1 means left, 1 means right.
		 */
		public function get FacingDirection():int
		{
			return displaycontainer.scaleX/Math.abs(displaycontainer.scaleX);
		}
		
		public function get CurrentAction():String
		{
			return currentAction;
		}
		
		public function IsAttacking():Boolean
		{
			return currentAction == "attacking";
		}
		
		public function Player(actionList:ActionList)
		{
			this.specimen = specimen;
			this.sprite = new Sprite();
			this.health = 100;
		}
		
		private static var healthMax : Number = 100;
		
		private var currentOpponent : Player;
		private var currentMatch : Match;
		private var health : Number;
		private var opponent : Player;
		private var displaycontainer : Sprite;
		private var specimen : Specimen;
		private var currentAction : String;
		private var position : Point;
		
	}
	
}