package fighter.controller.callback 
{
	import fighter.model.game.GameEvent;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	import fighter.model.game.Game;
	import fighter.model.player.Player;
	
	/**
	 * ...
	 * @author 
	 */
	public class GameCallbackImpl extends EventDispatcher implements GameCallback
	{
		
		/* INTERFACE fighter.controller.callback.GameCallback */
		
		public function OnFrameStart(game:Game):void
		{
			
		}
		
		public function OnFrameUpdate(game:Game):void
		{
			var p1 : Player = game.Player1;
			var p2 : Player = game.Player2;
			p1.Controller.Update(p1, game);
			p2.Controller.Update(p2, game);
			game.TimeElapsed += 1;
		}
		
		public function OnFrameEnd(game:Game):void
		{
			
		}
		
		public function OnGameStart(game:Game):void
		{
			game.Player1.Initialize();
			game.Player2.Initialize();
			
			var startPos1 : Point = game.StartingPositions[0];
			var startPos2 : Point = game.StartingPositions[1];
			
			if (Math.random() >= .5)
			{
				game.Player1.Position = startPos1;
				game.Player2.Position = startPos2;
			}
			else
			{
				game.Player1.Position = startPos2;
				game.Player2.Position = startPos1;
			}
			
			game.Player1.CurrentGame = game;
			game.Player2.CurrentGame = game;
			game.Player1.CurrentOpponent = game.Player2;
			game.Player2.CurrentOpponent = game.Player1;
		}
		
		public function OnGameEnd(game:Game):void
		{
			dispatchEvent(new GameEvent(game, GameEvent.GAME_OVER));
		}
		
	}
	
}