﻿package fighter.model.player
{
	import fighter.controller.player.PlayerController;
	import fighter.controller.player.action.Action;
	import fighter.model.game.Game;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Point;
	
	import org.evogen.entity.Specimen;
	
	/**
	 * ...
	 * @author Paul Gibler
	*/
	public class Player
	{
		public function get CurrentAction():Action
		{
			return currentAction;
		}
		public function set CurrentAction(currentAction:Action):void
		{
			this.currentAction = currentAction;
		}
		public function get Friction():Number
		{
			return .9
		}
		public function get Gravity():Number
		{
			return 1;
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
			return 20;
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
		public function set Health(val:Number):void
		{
			this.health = val;
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
		public function set CurrentAnimation(anim:MovieClip):void
		{
			this.animation = anim;
		}
		public function get CurrentAnimation():MovieClip
		{
			return this.animation;
		}
		
		public function get OnGround():Boolean
		{
			return position.y >= currentGame.GameLevel.GroundY;
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
		
		public function get HitDamage():Number
		{
			return this.hitDamage;
		}
		public function set HitDamage(num:Number):void
		{
			this.hitDamage = num;
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
		
		public function set IsBlocking(val:Boolean):void
		{
			this.isBlocking = val;
		}
		public function get IsBlocking():Boolean
		{
			return isBlocking;
		}
		public function get IsStunned():Boolean
		{
			return this.isStunned;
		}
		public function set IsStunned(val:Boolean):void
		{
			this.isStunned = val;
		}
		
		public function Player(controller:PlayerController)
		{
			this.specimen = specimen;
			this.displaycontainer = new Sprite();
			this.controller = controller;
		}
		
		public function Initialize():void
		{
			this.hitDamage = 0;
			this.health = 100;
			this.xSpeed = 0;
			this.ySpeed = 0;
			this.isAttacking = false;
			this.isStunned = false;
			this.isBlocking = false;
			this.animation = new MovieClip();
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
		private var isStunned : Boolean;
		private var xSpeed : Number;
		private var ySpeed : Number;
		private var currentAction : Action;
		private var facingDirection : Number;
		private var controller : PlayerController;
		private var currentOpponent : Player;
		private var currentGame : Game;
		private var health : Number;
		private var displaycontainer : Sprite;
		private var specimen : Specimen;
		private var isAttacking : Boolean;
		private var isBlocking : Boolean;
		private var position : Point;
		private var hitDamage : Number;
		private var animation : MovieClip;
		
	}
	
}