package fighter.controller.runner 
{
	import fighter.controller.callback.GameCallback;
	import fighter.model.game.Game;
	import fighter.model.game.Level;
	import fighter.model.player.Player;
	import fighter.model.tournament.Tournament;
	
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Paul Gibler
	 */
	public class GameRunner
	{
		
		public function GameRunner(callback:GameCallback, game:Game, tournament:Tournament) 
		{
			this.callback = callback;
			this.game = game;
			this.tournament = tournament;
		}
		
		public function Start():void
		{
			callback.OnGameStart(game);
		}
		
		public function Update(event:Event = null):void
		{
			callback.OnFrameUpdate( game );
		}
		
		private var tournament : Tournament;
		private var callback : GameCallback;
		private var player1 : Player;
		private var player2 : Player;
		private var level : Level;
		private var game : Game;		
	}
	
}