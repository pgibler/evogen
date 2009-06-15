package fighter.model.game
{
	import fighter.controller.callback.GameCallback;
	import fighter.model.player.Player;
	
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Paul Gibler
	 */
	public class Game 
	{
		public function get Callback():GameCallback
		{
			return this.callback;
		}
		public function get StartingPositions():Vector.<Point>
		{
			return startingPositions;
		}
		public function get GameLevel():Level
		{
			return level;
		}
		public function get ViewContainer():DisplayObjectContainer
		{
			return viewContainer;
		}
		public function get IsComplete():Boolean
		{
			return player1.Health <= 0 || player2.Health <= 0;
		}
		public function get Player1():Player
		{
			return player1;
		}
		public function get Player2():Player
		{
			return player2;
		}
		public function set TimeElapsed(timeElapsed:Number):void
		{
			this.timeElapsed = timeElapsed;
		}
		public function get TimeElapsed():Number
		{
			return timeElapsed;
		}
		
		public function Game(player1:Player, player2:Player, level:Level, callback : GameCallback) 
		{
			this.callback = callback;
			this.player1 = player1;
			this.player2 = player2;
			this.level = level;
			
			var threshhold : Number = 30;
			startingPositions = new Vector.<Point>();
			startingPositions.push(new Point(level.LeftWallX + threshhold, level.GroundY));
			startingPositions.push(new Point(level.RightWallX - threshhold, level.GroundY));
		}
		
		public function GetOpponentOf(player:Player):Player
		{
			if (player === player1)
			{
				return player2;
			}
			else if (player === player2)
			{
				return player1;
			}
			throw new Error("Player isn't in this game.");
		}
		
		private static var timeMax : Number;
		private var callback : GameCallback;
		private var startingPositions : Vector.<Point>;
		private var viewContainer : DisplayObjectContainer;
		private var timeElapsed : Number;
		private var level : Level;
		private var player1 : Player;
		private var player2 : Player;
		
	}
	
}