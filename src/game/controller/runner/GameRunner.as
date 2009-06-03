package game.controller.runner 
{
	import flash.events.Event;
	import game.controller.callback.GameCallback;
	import game.model.character.Character;
	import game.model.game.Level;
	import game.model.game.Game;
	
	/**
	 * ...
	 * @author Paul Gibler
	 */
	public class GameRunner
	{
		
		public function GameRunner(callback:GameCallback, game:Game, settings:TournamentSettings) 
		{
			this.callback = callback;
		}
		
		public function Start(event:Event=null):void
		{
			callback.OnMatchStart
			callback.OnRoundStart(game);
		}
		
		public function Update(event:Event = null):void
		{
			if (game.IsComplete)
			{
				callback.OnRoundEnd(game);
				game.IsComplete = false;
				callback.OnRoundStart
			}
			else
			{
				callback.OnFrameStart(game);
				callback.OnFrameUpdate(game);
				callback.OnFrameEnd(game);
			}
		}
		
		private var callback : GameCallback;
		private var character1 : Character;
		private var character2 : Character;
		private var level : Level;
		private var game : Game;
		
	}
	
}