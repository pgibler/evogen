package fighter.model.game 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author 
	 */
	public class GameEvent extends Event 
	{
		
		public static const GAME_OVER : String = "game_over";
		public static const GAME_START : String = "game_start";
		
		public function GetGame():Game
		{
			return game;
		}
		
		private var game : Game;
		
		public function GameEvent(game:Game, type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			this.game = game;
			
		} 
		
		public override function clone():Event 
		{ 
			return new GameEvent(game, type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("GameEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}