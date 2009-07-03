package fighter.controller.runner 
{
	import fighter.controller.callback.GameCallback;
	import fighter.model.game.Game;
	import fighter.model.game.Level;
	import fighter.model.player.Player;
	
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Paul Gibler
	 */
	public class GameRunner
	{
		
		public function GameRunner(game:Game) 
		{
			this.game = game;
		}
		
		public function Start():void
		{
			game.Callback.OnGameStart(game);
			game.Settings.DisplayContainer.addEventListener(Event.ENTER_FRAME, Update);
		}
		
		public function Update(event:Event = null):void
		{
			if(!game.IsComplete)
			{
				game.Callback.OnFrameUpdate( game );
			} 
			else
			{
				game.Settings.DisplayContainer.removeEventListener(Event.ENTER_FRAME, Update);
			}
		}
		
		private var callback : GameCallback;
		private var player1 : Player;
		private var player2 : Player;
		private var level : Level;
		private var game : Game;		
	}
	
}