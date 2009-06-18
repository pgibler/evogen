package fighter.model.player
{
	import fighter.controller.player.action.Action;
	import flash.display.Sprite;
	import flash.geom.Point;
	import fighter.controller.player.PlayerController;
	import fighter.model.game.Game;
	import org.evogen.entity.Specimen;
	
	/**
	 * ...
	 * @author Paul Gibler
	*/
	public class Player
	{
		public function get Friction():Number
		{
			return .9
		}
		public function get Gravity():Number
		{
			return 2;
		}
		public function set YSpeed(val:Number):void
		{
			this.ySpeed = val;
		}
		public function get YSpeed():Number
		{
			return ySpeed;
		}
		public function set XSpeed(val:Number):void
		{
			this.xSpeed = val;
		}
		public function get XSpeed():Number
		{
			return xSpeed;
		}
		public function get JumpSpeed():Number
		{
			return -20;
		}
		public function get WalkSpeed():Number
		{
			return 6;
		}
		public function get Controller():PlayerController
		{
			return controller;
		}
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
			return displaycontainer.y <= currentGame.GameLevel.GroundY;
		}
		
		public function set Position(p:Point):void
		{
			this.position = p;
		}
		public function get Position():Point
		{
			return position;
		}
		
		public function set CurrentGame(currentGame:Game):void
		{
			this.currentGame = currentGame;
		}
		public function get CurrentGame():Game
		{
			return this.currentGame;
		}
		
		public function set CurrentOpponent(currentOpponent:Player):void
		{
			this.currentOpponent = currentOpponent;
		}
		public function get CurrentOpponent():Player
		{
			return this.currentOpponent;
		}
		
		/**
		 * Returns the direction the player is facing. -1 means left, 1 means right.
		 */
		public function get FacingDirection():int
		{
			return facingDirection;
		}
		
		public function set IsAttacking(val:Boolean):void
		{
			this.isAttacking = val;
		}
		public function get IsAttacking():Boolean
		{
			return isAttacking;
		}
		
		public function set IsIdle(val:Boolean):void
		{
			this.isIdle = val;
		}
		public function get IsIdle():Boolean
		{
			return !isAttacking && !isBlocking;
		}
		
		public function Player(controller:PlayerController)
		{
			this.specimen = specimen;
			this.displaycontainer = new Sprite();
			this.controller = controller;
		}
		
		public function Initialize():void
		{
			this.health = 100;
			this.xSpeed = 0;
			this.ySpeed = 0;
			this.isAttacking = false;
		}
		
		public function FacePlayer(player:Player):Player
		{
			if (player.Position.x < position.x)
			{
				facingDirection = -1;
			}
			else if (player.Position.x > position.x)
			{
				facingDirection = 1;
			}
			return this;
		}
		
		private static var healthMax : Number = 100;
		private var xSpeed : Number;
		private var ySpeed : Number;
		private var facingDirection : Number;
		private var controller : PlayerController;
		private var currentOpponent : Player;
		private var currentGame : Game;
		private var health : Number;
		private var displaycontainer : Sprite;
		private var specimen : Specimen;
		private var isAttacking : Boolean;
		private var isBlocking : Boolean;
		private var isIdle : Boolean;
		private var position : Point;
		
	}
	
}