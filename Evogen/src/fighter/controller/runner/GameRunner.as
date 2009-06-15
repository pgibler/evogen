package fighter.controller.runner 
{
	import flash.events.Event;
	import fighter.controller.callback.GameCallback;
	import fighter.controller.callback.GameCallback;
	import fighter.model.game.Level;
	import fighter.model.player.Player;
	import fighter.model.game.Level;
	import fighter.model.game.Game;
	import fighter.model.tournament.TournamentSettings;
	
	/**
	 * ...
	 * @author Paul Gibler
	 */
	public class GameRunner
	{
		
		public function GameRunner(callback:GameCallback, game:Game, settings:TournamentSettings) 
		{
			this.callback = callback;
			this.game = game;
			this.settings = settings;
		}
		
		public function Start():void
		{
			callback.OnGameStart(game);
		}
		
		public function Update(event:Event = null):void
		{
			if (game.IsComplete)
			{
				callback.OnGameEnd(game);
			}
			else
			{
				callback.OnFrameStart(game);
				callback.OnFrameUpdate(game);
				callback.OnFrameEnd(game);
			}
		}
		
		private var settings : TournamentSettings
		private var callback : GameCallback;
		private var player1 : Player;
		private var player2 : Player;
		private var level : Level;
		private var game : Game;		
	}
	
}